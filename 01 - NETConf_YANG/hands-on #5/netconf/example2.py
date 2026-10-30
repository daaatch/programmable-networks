from device_info import ios_xe1
from ncclient import manager
import xmltodict

# list of devices to iterate through
devices = [
    {
        "name": "IOS-XR-Always-On-1",
        "address": "sandbox-iosxr-1.cisco.com",
        "port": 830,
        "username": "turno.1835365",
        "password": "2Jx4s__y4wHzEJ"
    }
]

# NETCONF filter to use (IOS-XR!)
netconf_filter = open("filter-xr-interfaces.xml").read()

if __name__ == '__main__':

    # iterate through each device in the list
    for device in devices:
        print(f"\n===================================================")
        print(f"connecting to: {device['name']} ({device['address']})")
        print(f"=====================================================")
        try:
            with manager.connect(host=ios_xe1["address"],
                                 port=ios_xe1["port"],
                                 username=ios_xe1["username"],
                                 password=ios_xe1["password"],
                                 hostkey_verify=False) as m:

                # get configuration info for interface
                netconf_reply = m.get(netconf_filter)

                # process the XML response
                parsed_dict = xmltodict.parse(netconf_reply.xml)
                
                # native IOS-XR RPC structural tree
                rpc_reply = parsed_dict.get("rpc-reply", {})
                data = rpc_reply.get("data", {})
                
                # IOS-XR specific structural key
                if not data or "interface-configurations" not in data:
                    print("no interface configurations found for this device.")
                    continue
                    
                intf_box = data["interface-configurations"]
                
                # cases of single, multiple or no interfaces
                if not intf_box or "interface-configuration" not in intf_box:
                    print("no active interfaces configured.")
                    continue
                    
                intf_data = intf_box["interface-configuration"]
        
                # xmltodict extracts a single element as a dict, and multiple as a list
                # enforce a list type structure to make looping generic
                if isinstance(intf_data, dict):
                    interface_list = [intf_data]
                else:
                    interface_list = intf_data

                print("available interfaces:")
                for interface in interface_list:
                    # in Cisco IOS-XR the target leaf node name is 'interface-name'
                    if "interface-name" in interface:
                        print(f"  - {interface['interface-name']}")
                    else:
                        print("  - Unknown Named Interface Node")

        except Exception as e:
            print(f"connection or parsing failure on {device['name']}: {e}")
