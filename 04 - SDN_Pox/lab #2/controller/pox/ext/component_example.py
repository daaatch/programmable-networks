from pox.core import core
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

def _handle_ConnectionUp(event):
    """triggered when a switch connects to the controller"""
    log.info("switch %s connected", event.dpid)
    
def _handle_PacketIn(event):
    """triggered when a packet arrives to a switch without a matching flow rule"""
    packet = event.parsed
    log.info("packet received on switch %s port %s: %s", event.dpid, event.port, packet)
    
def launch(parameter = "default_val"):
    """entry point that POX calls when loading the component"""
    """parameters defined here are set via CLI arguments"""
    log.info("launching custom component with parameter(s): %s", parameter)
    
    core.openflow.addListenerByName("ConnectionUp", _handle_ConnectionUp)
    core.openflow.addListenerByName("PacketIn", _handle_PacketIn)
