import networkx as nx
from pox.core import core
import pox.lib.packet as pkt
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

# ignore probe frames by matching the discovery MAC in discovery.py
DISCOVERY_MAC = "02:00:00:00:00:00"

class DijkstraRouting(object):

  def __init__(self):
    self.discovery = core.TopologyDiscovery
    core.openflow.addListeners(self)
    log.info("dijkstra routing initialized and hooked into topology discovery")

  def _build_graph(self):
    # build an undirected NetworkX graph from the discovered switches/links/hosts
    G = nx.Graph()

    # add discovered switches as nodes
    for dpid in self.discovery.switches.keys():
      G.add_node(dpid)

    # add links between switches with port mappings on each edge
    # discovery.links stores tuples: (src_dpid, src_port, dst_dpid, dst_port)
    for src_dpid, src_port, dst_dpid, dst_port in self.discovery.links:
      G.add_edge(
          src_dpid, dst_dpid, ports={src_dpid: src_port, dst_dpid: dst_port}
      )

    # add discovered hosts (keyed by EthAddr) connected to their access switch
    # discovery.hosts stores tuples: {host_mac: (switch_dpid, switch_port)}
    for host_mac, (sw_dpid, sw_port) in self.discovery.hosts.items():
      if sw_dpid in G:
        G.add_node(host_mac)
        G.add_edge(host_mac, sw_dpid, ports={sw_dpid: sw_port})

    return G

  def _flood(self, event):
    # flood unknown destination or broadcast frames (as ARP requests) to discover hosts
    po = of.ofp_packet_out()
    po.data = event.ofp
    po.in_port = event.ofp.in_port
    po.actions.append(of.ofp_action_output(port=of.OFPP_FLOOD))
    event.connection.send(po)

  def _install_path(self, G, path, src_mac, dst_mac, event):
    # install FlowMod rules on every switch along the computed shortest path
    # path format: [src_host_mac, sw_1, sw_2, ..., sw_n, dst_host_mac]
    switches_on_path = path[1:-1]

    for i, sw_dpid in enumerate(switches_on_path):
      next_hop = path[i + 2]  # either the next switch or dst_host_mac
      out_port = G[sw_dpid][next_hop]["ports"][sw_dpid]

      fm = of.ofp_flow_mod()
      fm.idle_timeout = 30
      fm.hard_timeout = 60
      fm.match.dl_src = src_mac
      fm.match.dl_dst = dst_mac
      fm.actions.append(of.ofp_action_output(port=out_port))

      # if the current switch raised PacketIn attach buffer_id to forward the waiting packet
      if (sw_dpid == event.dpid and event.ofp.buffer_id not in (-1, of.NO_BUFFER, None)):
        fm.buffer_id = event.ofp.buffer_id
      
      conn = self.discovery.switches.get(sw_dpid)
      if conn:
        conn.send(fm)
        log.info(
            f"[FLOW INSTALLED] switch {sw_dpid}: {src_mac} -> {dst_mac} out"
            f" port {out_port}"
        )

    # if the triggering switch didn't buffer the packet (buffer_id == -1) send it out explicitly
    if (
        event.ofp.buffer_id in (-1, of.NO_BUFFER, None)
        and event.dpid in switches_on_path
    ):
      idx = switches_on_path.index(event.dpid)
      next_hop = path[idx + 2]
      out_port = G[event.dpid][next_hop]["ports"][event.dpid]
      po = of.ofp_packet_out()
      po.data = event.ofp
      po.actions.append(of.ofp_action_output(port=out_port))
      event.connection.send(po)

  def _handle_PacketIn(self, event):
    packet = event.parsed
    if not packet or not packet.parsed:
      return

    # ignore discovery frames handled by discovery.py
    if str(packet.src) == DISCOVERY_MAC or packet.type == pkt.ethernet.LLDP_TYPE:
      return

    src_mac = packet.src
    dst_mac = packet.dst

    # broadcast/multicast (as initial ARP requests) must be flooded so the target host replies
    if dst_mac.is_multicast:
      self._flood(event)
      return

    # build current topology graph and check if both endpoints exist
    G = self._build_graph()
    if src_mac not in G or dst_mac not in G:
      self._flood(event)
      return

    # compute shortest path using djikstra algorithm
    try:
      path = nx.shortest_path(G, source=src_mac, target=dst_mac, method="dijkstra")
      log.info(f"[SHORTEST PATH] {src_mac} -> {dst_mac}: {path}")
      self._install_path(G, path, src_mac, dst_mac, event)
    except nx.NetworkXNoPath:
      log.warning(f"[NO PATH] No path found between {src_mac} and {dst_mac}")
      self._flood(event)


def launch():
  core.registerNew(DijkstraRouting)
