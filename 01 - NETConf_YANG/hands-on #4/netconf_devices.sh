#!/bin/bash

source venv/bin/activate

(venv) cd netconf
(venv) python3 example0.py

Connecting to IOS-XR at sandbox-iosxr-1.cisco.com...
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
(...)
http://openconfig.net/yang/macsec?module=openconfig-macsec&revision=2022-04-28&deviations=cisco-xr-openconfig-macsec-deviations
http://openconfig.net/yang/macsec/types?module=openconfig-macsec-types&revision=2019-07-01
http://cisco.com/ns/yang/cisco-xr-openconfig-sampling-sflow-deviations?module=cisco-xr-openconfig-sampling-sflow-deviations&revision=2023-01-18
http://openconfig.net/yang/sampling/sflow?module=openconfig-sampling-sflow&revision=2022-06-21&deviations=cisco-xr-openconfig-sampling-sflow-deviations
http://openconfig.net/yang/sampling?module=openconfig-sampling&revision=2022-06-21
http://openconfig.net/yang/lldp?module=openconfig-lldp&revision=2018-11-21&deviations=cisco-xr-openconfig-lldp-deviations
http://cisco.com/ns/yang/cisco-xr-openconfig-lldp-deviations?module=cisco-xr-openconfig-lldp-deviations&revision=2024-10-09
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
	<interface-name>HundredGigE0/0/0/0</interface-name>
	<description>CUST-PORT: WIBX - ORD-2026-0455 - 400G - paris</description>
	<bundle-member xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-bundlemgr-cfg">
		<id>
			<bundle-id>1</bundle-id>
			<port-activity>active</port-activity>
		</id>
	</bundle-member>
	<statistics xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-infra-statsd-cfg">
		<load-interval>30</load-interval>
	</statistics>
</interface-configuration>

(venv) python3 example2.py

=============================================================
connecting to: IOS-XR-Always-On-1 (sandbox-iosxr-1.cisco.com)
=============================================================
available interfaces:
  - HundredGigE0/0/0/0
  - HundredGigE0/0/0/1
  - HundredGigE0/0/0/2
  - HundredGigE0/0/0/3
  - GigabitEthernet0/0/0/2
  - Loopback0
  - Loopback77
  - Loopback100
  - Loopback250
  - Loopback999
  - Bundle-Ether1
  - Bundle-Ether2
  - Bundle-Ether100
  - MgmtEth0/RP0/CPU0/0
  - GigabitEthernet0/0/0/0
  - GigabitEthernet0/0/0/1

(venv) deactivate

