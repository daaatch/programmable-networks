from pox.core import core

log = core.getLogger()

class component_b(object):
    def __init__(self):
        # wait for component a before starting to listen
        core.call_when_ready(self._setup_listener, "component_a")

    def _setup_listener(self):
        # listener for the PacketInSeen event on component a
        core.component_a.addListenerByName("PacketInSeen", self._handle_packetInSeen)
        log.info("component b listening for events from component a")

    def _handle_packetInSeen(self, event):
        # print message on screen when packet in occurs
        print("component a has seen an OFP packet in")

def launch():
    component_b()
