from pox.core import core
from pox.lib.revent.revent import EventMixin
from pox.lib.revent.revent import Event

log = core.getLogger()

# custom event class
class PacketInSeen(Event):
    def __init__(self):
        super(PacketInSeen, self).__init__()

class component_a(EventMixin):
    # custom events this component can raise
    _eventMixin_events = set([
        PacketInSeen,
    ])

    def __init__(self):
        # listen to openflow's packet in events
        core.openflow.addListenerByName("PacketIn", self._handle_PacketIn)

    def _handle_PacketIn(self, event):
        log.info("component a: openflow packet in event received")
        # raise the event
        self.raiseEvent(PacketInSeen())

def launch():
    app = component_a()
    # register component a into POX core
    core.register("component_a", app)
    log.info("component a registered in POX core.")
