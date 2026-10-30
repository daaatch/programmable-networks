#!/bin/bash

# close running processes in the kathara container environment
kathara connect controller

# kill the currently running POX process
root@controller:/# pkill -f pox.py

# force python to use UTF-8 encoding
root@controller:/# export PYTHONIOENCODING=utf-8

# call the component
root@controller:/# ./pox/pox.py samples.pretty_log openflow.of_01 -port=6653 ip_detector
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[ip_detector   ] component loaded
[version       ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version       ] You are running Python 3.11.
[version       ] If you run into problems, try using a supported version.
[core          ] POX 0.7.0 (gar) is up.
[openflow.of_01] [a6-d7-d8-3e-0b-4b 1] connected

# run sendIP/sendARP scripts in h1
kathara connect h1

root@h1:/# python3 sendARP.py
ARP packet sent from h1

root@h1:/# python3 sendIP.py
WARNING: MAC address to reach destination not found. Using broadcast.
IP packet sent from h1

root@h1:/# exit

# back to the controller terminal
root@controller:/# ./pox/pox.py samples.pretty_log openflow.of_01 -port=6653 ip_detector
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[ip_detector   ] component loaded
[version       ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version       ] You are running Python 3.11.
[version       ] If you run into problems, try using a supported version.
[core          ] POX 0.7.0 (gar) is up.
[openflow.of_01] [a6-d7-d8-3e-0b-4b 1] connected
[ip_detector   ] [IP_detector] ARP packet detected
[ip_detector   ] [IP_detector] ARP packet detected 
[packet        ] (dns) packet data too short to parse header: data len 0
[ip_detector   ] [IP_detector] IP packet detected: source IP: 10.0.1.1 destination IP: 10.0.2.2
[openflow.of_01] [a6-d7-d8-3e-0b-4b 1] disconnected
[core          ] Down.

root@controller:/# exit
