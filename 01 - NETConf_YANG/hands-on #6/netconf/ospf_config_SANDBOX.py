from device_info import ios_xe1
from ncclient import manager


def main():
    """
    Main method that prints netconf capabilities of device.
    """

    with manager.connect(host=ios_xe1["address"], port=ios_xe1["port"],
                         username=ios_xe1["username"],
                         password=ios_xe1["password"],
                         hostkey_verify=False) as m:

        # IOS-XR Native OSPF configuration maps interfaces directly to areas
        rpc = '''
            <config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
                <ospf xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-ipv4-ospf-cfg">
                    <processes>
                        <process>
                            <process-name>1</process-name>
                            <default-vrf>
                                <area-addresses>
                                    <area-address>
                                        <area-id>0</area-id>
                                        <name-scopes>
                                            <name-scope>
                                                <interface-name>GigabitEthernet0/0/0/0</interface-name>
                                            </name-scope>
                                        </name-scopes>
                                    </area-address>
                                </area-addresses>
                            </default-vrf>
                        </process>
                    </processes>
                </ospf>
            </config>
            '''

        # send configuration to the candidate datastore
        print("sending configuration to the candidate datastore...")
        reply = m.edit_config(rpc, target='candidate')
        print(f"edit config reply: {reply}")
        
        # commit the configuration to make it active
        print("committing configuration changes...")
        commit_reply = m.commit()
        print(f"commit reply: {commit_reply}")

if __name__ == '__main__':
    main()
