from device_info import ios_xe1
from ncclient import manager
import xml.dom.minidom

# NETCONF filter to use (IOS-XR!)
netconf_filter = open("filter-xr-interfaces.xml").read()

if __name__ == '__main__':
    with manager.connect(host=ios_xe1["address"],
                         port=ios_xe1["port"],
                         username=ios_xe1["username"],
                         password=ios_xe1["password"],
                         hostkey_verify=False) as m:

        # get running configuration
        netconf_reply = m.get_config("running", netconf_filter)
        
        # parse the XML text into a DOM object
        dom = xml.dom.minidom.parseString(netconf_reply.xml)
        
        # look for the native IOS-XR tag name
        interfaces = dom.getElementsByTagName("interface-configuration")
        
        # print the first interface configuration nicely formatted
        print(interfaces[0].toprettyxml())
