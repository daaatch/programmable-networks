#!/bin/bash

python3 -m venv venv
source venv/bin/activate

(venv) cd netconf

(venv) python3 example0.py

Connecting to IOS-XR (!) at sandbox-iosxr-1.cisco.com...
Here are the NETCONF Capabilities:
urn:ietf:params:netconf:base:1.1
urn:ietf:params:netconf:capability:candidate:1.0
urn:ietf:params:netconf:capability:rollback-on-error:1.0
urn:ietf:params:netconf:capability:validate:1.1
urn:ietf:params:netconf:capability:confirmed-commit:1.1
urn:ietf:params:netconf:capability:notification:1.0
urn:ietf:params:netconf:capability:interleave:1.0
http://cisco.com/ns/yang/Cisco-IOS-XR-config-mda-cfg?module=Cisco-IOS-XR-config-mda-cfg&revision=2019-04-05
http://cisco.com/ns/yang/Cisco-IOS-XR-ipv4-bgp-datatypes?module=Cisco-IOS-XR-ipv4-bgp-datatypes&revision=2024-11-26
http://cisco.com/ns/yang/Cisco-IOS-XR-um-mpls-ldp-cfg?module=Cisco-IOS-XR-um-mpls-ldp-cfg&revision=2022-06-01
http://cisco.com/ns/yang/Cisco-IOS-XR-infra-xtc-agent-oper?module=Cisco-IOS-XR-infra-xtc-agent-oper&revision=2025-06-22
http://cisco.com/ns/yang/Cisco-IOS-XR-um-if-dhcp-client-options-cfg?module=Cisco-IOS-XR-um-if-dhcp-client-options-cfg&revision=2022-07-11
http://cisco.com/ns/yang/Cisco-IOS-XR-ethernet-cfm-act?module=Cisco-IOS-XR-ethernet-cfm-act&revision=2025-05-02
http://cisco.com/ns/yang/Cisco-IOS-XR-ip-static-ipv6-oper?module=Cisco-IOS-XR-ip-static-ipv6-oper&revision=2025-04-28
http://cisco.com/ns/yang/Cisco-IOS-XR-segment-routing-ms-oper?module=Cisco-IOS-XR-segment-routing-ms-oper&revision=2023-08-11
http://cisco.com/ns/yang/Cisco-IOS-XR-um-router-amt-cfg?module=Cisco-IOS-XR-um-router-amt-cfg&revision=2019-08-20
http://cisco.com/ns/yang/Cisco-IOS-XR-infra-ltrace-cfg?module=Cisco-IOS-XR-infra-ltrace-cfg&revision=2019-04-05
http://cisco.com/ns/yang/Cisco-IOS-XR-clns-isis-cfg?module=Cisco-IOS-XR-clns-isis-cfg&revision=2024-02-01
http://cisco.com/ns/yang/Cisco-IOS-XR-l2-eth-infra-datatypes?module=Cisco-IOS-XR-l2-eth-infra-datatypes&revision=2019-04-05
(...)
http://openconfig.net/yang/openconfig-icmpv4-types?module=openconfig-icmpv4-types&revision=2023-01-26
http://openconfig.net/yang/lacp?module=openconfig-lacp&revision=2023-12-11&deviations=cisco-xr-openconfig-lacp-deviations
http://cisco.com/ns/yang/cisco-xr-openconfig-lacp-deviations?module=cisco-xr-openconfig-lacp-deviations&revision=2023-03-27
http://openconfig.net/yang/telemetry?module=openconfig-telemetry&revision=2018-11-21&deviations=cisco-xr-openconfig-telemetry-deviations
http://cisco.com/ns/yang/cisco-xr-openconfig-telemetry-deviations?module=cisco-xr-openconfig-telemetry-deviations&revision=2024-02-01
http://openconfig.net/yang/gribi?module=openconfig-gribi&revision=2021-04-06
http://openconfig.net/yang/openconfig-icmpv6-types?module=openconfig-icmpv6-types&revision=2023-05-02

(venv) python3 example1.py

<interface-configuration>
	<active>pre</active>	
	<interface-name>HundredGigE0/0/0/3</interface-name>
	<description>CUST-PORT: WIBX - ORD-2026-0455 - 100G - paris</description>
	<bundle-member xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-bundlemgr-cfg">
		<id>      
			<bundle-id>2</bundle-id>
			<port-activity>active</port-activity>
		</id>
	</bundle-member>
	<statistics xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-infra-statsd-cfg">
		<load-interval>30</load-interval>
	</statistics>
</interface-configuration>

(venv) python3 example2.py

connecting to: IOS-XR-Always-On-1 (sandbox-iosxr-1.cisco.com)

available interfaces:
  - HundredGigE0/0/0/3
  - HundredGigE0/0/0/4
  - Loopback0
  - Loopback10
  - Bundle-Ether2
  - Bundle-Ether3
  - MgmtEth0/RP0/CPU0/0
  - GigabitEthernet0/0/0/0
  - GigabitEthernet0/0/0/1

(venv) python3 example3.py

initializing netconf connections...
connected to IOS-XR-Always-On-1 (sandbox-iosxr-1.cisco.com)

polling transmitted bytes at 2026-06-04 16:36:07

Device: IOS-XR-Always-On-1
  interface: GigabitEthernet0/0/0/0    | transmitted bytes: 0 (No Traffic / Uninitialized)
  interface: GigabitEthernet0/0/0/1    | transmitted bytes: 0 (No Traffic / Uninitialized)

waiting 5 seconds before next poll...

polling transmitted bytes at 2026-06-04 16:36:13

Device: IOS-XR-Always-On-1
  interface: GigabitEthernet0/0/0/0    | transmitted bytes: 0 (No Traffic / Uninitialized)
  interface: GigabitEthernet0/0/0/1    | transmitted bytes: 0 (No Traffic / Uninitialized)

waiting 5 seconds before next poll...

script interrupted by user, shutting down gracefully...
closing session for IOS-XR-Always-On-1

(venv) python3 example4.py

processing device: sandbox-iosxr-1.cisco.com
generated configuration payload:

<config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
    <ospf xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-ipv4-ospf-cfg">
        <processes>
            <process>
                <process-name>1</process-name>
                <default-vrf>
                    <area-addresses>
                        <area-area-id>
                            <area-id>0</area-id>
                            <name-scopes>
                                <name-scope>
                                    <interface-name>GigabitEthernet0/0/0/0</interface-name>
                                </name-scope>
                            </name-scopes>
                        </area-area-id>
                    </area-addresses>
                </default-vrf>
            </process>
        </processes>
    </ospf>
</config>

connecting to sandbox-iosxr-1.cisco.com via NETCONF...
sending OSPF configuration to candidate datastore...
edit-config reply: <?xml version="1.0"?>
<rpc-reply message-id="urn:uuid:b22223cf-11e0-4c1d-97e2-1792e94807ab" xmlns:nc="urn:ietf:params:xml:ns:netconf:base:1.0" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
 <ok/>
</rpc-reply>

committing configuration changes...
commit reply: <?xml version="1.0"?>
<rpc-reply message-id="urn:uuid:6b6ae320-eb21-4dc9-8cdd-f4460bef251a" xmlns:nc="urn:ietf:params:xml:ns:netconf:base:1.0" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
 <ok/>
</rpc-reply>

successfully configured OSPF on sandbox-iosxr-1.cisco.com!

processing device: sandbox-iosxr-1.cisco.com
generated configuration payload:

<config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
    <ospf xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-ipv4-ospf-cfg">
        <processes>
            <process>
                <process-name>1</process-name>
                <default-vrf>
                    <area-addresses>
                        <area-area-id>
                            <area-id>0</area-id>
                            <name-scopes>
                                <name-scope>
                                    <interface-name>GigabitEthernet0/0/0/1</interface-name>
                                </name-scope>
                            </name-scopes>
                        </area-area-id>
                    </area-addresses>
                </default-vrf>
            </process>
        </processes>
    </ospf>
</config>

connecting to sandbox-iosxr-1.cisco.com via NETCONF...
sending OSPF configuration to candidate datastore...
edit-config reply: <?xml version="1.0"?>
<rpc-reply message-id="urn:uuid:00ac8ea1-4086-4730-950a-fffd6c98e3f1" xmlns:nc="urn:ietf:params:xml:ns:netconf:base:1.0" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
 <ok/>
</rpc-reply>

committing configuration changes...
commit reply: <?xml version="1.0"?>
<rpc-reply message-id="urn:uuid:d0cb223a-e3a3-4fce-b919-24c6a7b7abe5" xmlns:nc="urn:ietf:params:xml:ns:netconf:base:1.0" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
 <ok/>
</rpc-reply>

successfully configured OSPF on sandbox-iosxr-1.cisco.com!

(venv) deactivate
