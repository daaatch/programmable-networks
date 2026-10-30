#! /usr/bin/env python
"""
Copyright (c) 2019 Cisco and/or its affiliates.

This software is licensed to you under the terms of the Cisco Sample
Code License, Version 1.0 (the "License"). You may obtain a copy of the
License at

               https://developer.cisco.com/docs/licenses

All use of the material herein must be in accordance with the terms of
the License. All rights not expressly granted by the License are
reserved. Unless required by applicable law or agreed to separately in
writing, software distributed under the License is distributed on an "AS
IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
or implied.
"""

__author__ = "Hank Preston <hapresto@cisco.com>"
__contributors__ = "Bryan Byrne <brybyrne@cisco.com>"
__copyright__ = "Copyright (c) 2019 Cisco and/or its affiliates."
__license__ = "Cisco Sample Code License, Version 1.0"

from device_info import ios_xe1
from ncclient import manager

# define the IOS-XR native OSPF template using Python string formatting placeholders
ospf_template = """
<config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
    <ospf xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-ipv4-ospf-cfg">
        <processes>
            <process>
                <process-name>{process_name}</process-name>
                <default-vrf>
                    <area-addresses>
                        <area-area-id>
                            <area-id>{area_id}</area-id>
                            <name-scopes>
                                <name-scope>
                                    <interface-name>{interface_name}</interface-name>
                                </name-scope>
                            </name-scopes>
                        </area-area-id>
                    </area-addresses>
                </default-vrf>
            </process>
        </processes>
    </ospf>
</config>
"""

# define inventory data structure containing devices
device_inventory = [
    {
        "connection": {
            "address": "sandbox-iosxr-1.cisco.com",
            "port": 830,
            "username": "turno.1835365",
            "password": "4s4F_cB-o_gV5Aa"
        },
        "ospf_config": {
            "process_name": "1",
            "area_id": "0",
            "interface_name": "GigabitEthernet0/0/0/0"
        }
    },
    {
        "connection": {
            "address": "sandbox-iosxr-1.cisco.com",
            "port": 830,
            "username": "turno.1835365",
            "password": "4s4F_cB-o_gV5Aa"
        },
        "ospf_config": {
            "process_name": "1",
            "area_id": "0",
            "interface_name": "GigabitEthernet0/0/0/1"
        }
    }
]

def automate_ospf_deployment():
    # loop through each device in our inventory data structure
    for device in device_inventory:
        conn = device["connection"]
        ospf = device["ospf_config"]
        
        print(f"\n=========================================")
        print(f"processing device: {conn['address']}")
        print(f"=========================================")
        
        # Build the dynamic payload using variables from our data structure
        netconf_payload = ospf_template.format(
            process_name=ospf["process_name"],
            area_id=ospf["area_id"],
            interface_name=ospf["interface_name"]
        )
        
        print("generated configuration payload:")
        print(netconf_payload)
        
        # Establish the connection inside a try-except block to gracefully handle down nodes
        try:
            print(f"connecting to {conn['address']} via NETCONF...")
            with manager.connect(
                host=conn["address"],
                port=conn["port"],
                username=conn["username"],
                password=conn["password"],
                hostkey_verify=False
            ) as m:
                
                # Step 1: Send configuration payload to the candidate datastore
                print("sending OSPF configuration to candidate datastore...")
                edit_reply = m.edit_config(netconf_payload, target='candidate')
                print(f"edit-config reply: {edit_reply}")
                
                # Step 2: Commit changes to transition configuration from candidate to running
                print("committing configuration changes...")
                commit_reply = m.commit()
                print(f"commit reply: {commit_reply}")
                print(f"successfully configured OSPF on {conn['address']}!")
                
        except Exception as e:
            print(f"ERROR: failed to configure device {conn['address']}. details: {e}")

if __name__ == '__main__':
    automate_ospf_deployment()

