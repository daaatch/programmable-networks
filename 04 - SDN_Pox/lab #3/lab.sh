#!/bin/bash

# close running processes in the kathara container environment
kathara connect controller

# kill the currently running POX process
root@controller:/# pkill -f pox.py

# verify port 6653 (port open -> no output)
root@controller:/# netstat -tlpn | grep 6653

# force python to use UTF-8 encoding
root@controller:/# export PYTHONIOENCODING=utf-8

# call the components
./pox/pox.py samples.pretty_log openflow.of_01 -port=6653 forwarding.l2_learning component_a component_b
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[component_a   ] component a registered in POX core.
[component_b   ] component b listening for events from component a
[version       ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version       ] You are running Python 3.11.
[version       ] If you run into problems, try using a supported version.
[core          ] POX 0.7.0 (gar) is up.
[openflow.of_01] [de-73-19-27-e3-4e 1] connected

root@controller:/# exit

# meanwhile ping from h1 to h2 to generate traffic
kathara connect h1

root@h1:/# ping -c 3 10.0.2.2
PING 10.0.2.2 (10.0.2.2) 56(84) bytes of data.
64 bytes from 10.0.2.2: icmp_seq=1 ttl=64 time=24.4 ms
64 bytes from 10.0.2.2: icmp_seq=2 ttl=64 time=2.44 ms
64 bytes from 10.0.2.2: icmp_seq=3 ttl=64 time=1.86 ms

--- 10.0.2.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 1.858/9.555/24.372/10.479 ms

root@h1:/# exit

kathara connect controller

root@controller:/# ./pox/pox.py samples.pretty_log openflow.of_01 -port=6653 forwarding.l2_learning component_a component_b
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[component_a   ] component a registered in POX core.
[component_b   ] component b listening for events from component a
[version       ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version       ] You are running Python 3.11.
[version       ] If you run into problems, try using a supported version.
[core          ] POX 0.7.0 (gar) is up.
[openflow.of_01] [de-73-19-27-e3-4e 1] connected
[component_a   ] component a: openflow packet in event received
component a has seen an OFP packet in
[component_a   ] component a: openflow packet in event received
component a has seen an OFP packet in
[component_a   ] component a: openflow packet in event received
component a has seen an OFP packet in
[component_a   ] component a: openflow packet in event received
component a has seen an OFP packet in
[component_a   ] component a: openflow packet in event received
component a has seen an OFP packet in
[component_a   ] component a: openflow packet in event received
component a has seen an OFP packet in
[core          ] Going down...
[openflow.of_01] [de-73-19-27-e3-4e 1] disconnected
[core          ] Down.

root@controller:/# exit
