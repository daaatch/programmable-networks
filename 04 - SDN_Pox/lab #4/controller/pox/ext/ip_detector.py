from pox.core import core
import pox.lib.packet as pkt

log = core.getLogger()

class IP_detector(object):
    def __init__(self):
        # handler for packet in events
        core.openflow.addListenerByName("PacketIn", self._handle_PacketIn)

    def _handle_PacketIn(self, event):
        packet = event.parsed
        
        # ignore unparseable packets
        if not packet.parsed:
            return  

        # check if packet contains IPv4 header
        ip_packet = packet.find('ipv4')

        if ip_packet is not None:
            log.info("[IP_detector] IP packet detected: source IP: %s destination IP: %s", ip_packet.srcip, ip_packet.dstip)
        else:
            # check for ARP or another protocol
            arp_packet = packet.find('arp')
            if arp_packet is not None:
                log.info("[IP_detector] ARP packet detected")
            else:
                log.info("[IP_detector] packet detected (EtherType: 0x%04x).", packet.type)

def launch():
    IP_detector()
    log.info("component loaded")
