from pox.core import core

log = core.getLogger()

class component_b(object):
    def __init__(self):
        core.call_when_ready(self.call_component_a, "component_a")
        
    def call_component_a(self):
        log.info("component b startup: invoke component a print method:")
        core.component_a.print_message()
    
def launch():
    component_b()
