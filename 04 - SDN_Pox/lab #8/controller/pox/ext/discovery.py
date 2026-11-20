from pox.core import core
import pox.openflow.libopenflow_01 as of
import pox.lib.packet as pkt
from pox.lib.addresses import EthAddr
from pox.lib.recoco import Timer

log = core.getLogger()

# src MAC
discovery_mac = EthAddr("02:00:00:00:00:00")                                    

class TopologyDiscovery(object):

    def __init__(self, probe_interval=10):
        core.openflow.addListeners(self)
        self.switches = {}  
        self.links = set()  
        self.hosts = {}  
        self.timer = Timer(probe_interval, self._send_periodic_probes, recurring=True)

    # use a 6-byte destination MAC to encode DPID (4 bytes) and port (2 bytes)
    def _encode_dpid_port(self, dpid, port_no):
        b1 = (dpid >> 24) & 0xFF
        b2 = (dpid >> 16) & 0xFF
        b3 = (dpid >> 8) & 0xFF
        b4 = dpid & 0xFF
        p1 = (port_no >> 8) & 0xFF
        p2 = port_no & 0xFF
        return EthAddr(f"{b1:02x}:{b2:02x}:{b3:02x}:{b4:02x}:{p1:02x}:{p2:02x}")

    # decode the destination MAC = (DPID + PORT)
    def _decode_dpid_port(self, mac):
        raw = mac.toRaw()
        dpid = (raw[0] << 24) | (raw[1] << 16) | (raw[2] << 8) | raw[3]
        port_no = (raw[4] << 8) | raw[5]
        return dpid, port_no

    # switch discovery trigger
    def _handle_ConnectionUp(self, event):
        dpid = event.dpid
        self.switches[dpid] = event.connection
        log.info(f"[SWITCH DISCOVERED] switch DPID: {dpid}")

        # explicit flow rule to send discovery packets
        fm = of.ofp_flow_mod()
        fm.priority = 65535  # highest priority
        fm.match.dl_src = discovery_mac
        fm.match.dl_type = pkt.ethernet.ARP_TYPE
        fm.actions.append(of.ofp_action_output(port=of.OFPP_CONTROLLER))
        event.connection.send(fm)

    def _handle_ConnectionDown(self, event):
        if event.dpid in self.switches:
            del self.switches[event.dpid]
            log.info(f"[SWITCH DISCONNECTED] switch DPID: {event.dpid}")

    def _send_periodic_probes(self):
        for dpid, connection in list(self.switches.items()):
            for port in connection.ports.values():
                if port.port_no >= of.OFPP_MAX:
                    continue
                self.send_discovery_packet(connection, port.port_no)

    # construct the discovery packet with empty ARP payload
    def send_discovery_packet(self, connection, out_port):
        eth = pkt.ethernet()
        eth.src = discovery_mac
        eth.dst = self._encode_dpid_port(connection.dpid, out_port)
        eth.type = pkt.ethernet.ARP_TYPE
        eth.payload = pkt.arp() 
        po = of.ofp_packet_out()
        po.data = eth.pack()
        po.actions.append(of.ofp_action_output(port=out_port))
        connection.send(po)

    # packet processing for topology discovery
    def _handle_PacketIn(self, event):
        packet = event.parsed
        if not packet or not packet.parsed:
            return

        # link discovery
        if packet.src == discovery_mac:
            src_dpid, src_port = self._decode_dpid_port(packet.dst)
            dst_dpid = event.dpid
            dst_port = event.ofp.in_port

            link = (src_dpid, src_port, dst_dpid, dst_port)
            if link not in self.links:
                self.links.add(link)
                log.info(
                    f"[LINK DISCOVERED] switch {src_dpid} (port {src_port}) "
                    f"<---> switch {dst_dpid} (port {dst_port})"
                )
            return

        # host discovery
        host_mac = packet.src
        in_dpid = event.dpid
        in_port = event.ofp.in_port

        # check if the packet arrived from another switch rather than an edge host
        is_switch_port = any(
            (dst_dpid == in_dpid and dst_port == in_port)
            or (src_dpid == in_dpid and src_port == in_port)
            for (src_dpid, src_port, dst_dpid, dst_port) in self.links
        )

        if (
            host_mac != discovery_mac
            and not host_mac.is_multicast
            and not is_switch_port
        ):
          if host_mac not in self.hosts:
            self.hosts[host_mac] = (in_dpid, in_port)
            log.info(
                f"[HOST DISCOVERED] host (MAC {host_mac}) attached to "
                f"switch {in_dpid} (port {in_port})"
            )

def launch(interval=10):
    core.registerNew(TopologyDiscovery, probe_interval=int(interval))
