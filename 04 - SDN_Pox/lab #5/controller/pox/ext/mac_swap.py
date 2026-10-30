from pox.core import core
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

class mac_swapper(object):
    def __init__(self):
        core.openflow.addListenerByName("PacketIn", self._handle_PacketIn)

    def _handle_PacketIn(self, event):
        eth_frame = event.parsed
        if not eth_frame.parsed:
            return

        log.info("[MAC SWAPPER] original -> source: %s, destination: %s", eth_frame.src, eth_frame.dst)

        # swap source and destination MAC addresses
        eth_frame.src, eth_frame.dst = eth_frame.dst, eth_frame.src

        log.info("[MAC SWAPPER] swapped  -> source: %s, destination: %s", eth_frame.src, eth_frame.dst)

        # packet_out message
        msg = of.ofp_packet_out()
        msg.data = eth_frame.pack()
        msg.actions.append(of.ofp_action_output(port = event.port))
        connection = event.connection
        connection.send(msg)

def launch():
    mac_swapper()
    log.info("MAC swapping component loaded")
