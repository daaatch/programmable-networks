from pox.core import core

log = core.getLogger()

class component_a(object):
    def __init__(self, message="hello from component a"):
        self.hello_message = message 
    
    def print_message(self):
        log.info("component a wants to say: %s", self.hello_message)
        
def launch(hello_message="hello from component a"):
    app = component_a(hello_message)
    core.register("component_a", app)
    log.info("component a successfully registered to the POX core")
