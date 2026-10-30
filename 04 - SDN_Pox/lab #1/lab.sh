#!/bin/bash

# restart POX controller (kathara container environment does not have variables set already -> error)
kathara connect controller

# kill the currently running POX process
root@controller:/# pkill -f pox.py

# verify port 6653 (port open -> no output)
root@controller:/# netstat -tlpn | grep 6653

# force python to use UTF-8 encoding and restart POX with l2_learning enabled
root@controller:/# export PYTHONIOENCODING=utf-8
./pox/pox.py samples.pretty_log openflow.discovery forwarding.l2_learning openflow.of_01 -port=6653
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[version                ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version                ] You are running Python 3.11.
[version                ] If you run into problems, try using a supported version.
[core                   ] POX 0.7.0 (gar) is up.
[openflow.of_01         ] [22-2f-a7-65-01-4f 1] connected

root@controller:/# exit

# generate traffic
kathara connect h1

root@h1:/# ping -c 3 10.0.2.2
PING 10.0.2.2 (10.0.2.2) 56(84) bytes of data.
64 bytes from 10.0.2.2: icmp_seq=1 ttl=64 time=0.771 ms
64 bytes from 10.0.2.2: icmp_seq=2 ttl=64 time=0.972 ms
64 bytes from 10.0.2.2: icmp_seq=3 ttl=64 time=0.962 ms
--- 10.0.2.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2016ms
rtt min/avg/max/mdev = 0.771/0.901/0.972/0.092 ms

root@h1:/# exit

# dump the flow table
kathara connect s1

root@s1:/# ovs-vsctl show
74f92321-036f-4340-a3b1-4b93ef77ecb9
    Bridge s1
        Controller "tcp:20.0.1.4:6653"
            is_connected: true
        Port eth0
            Interface eth0
        Port eth1
            Interface eth1
        Port s1
            Interface s1
                type: internal
    ovs_version: "3.1.0"
    
root@s1:/# ovs-ofctl dump-flows s1
 cookie=0x0, duration=18.989s, table=0, n_packets=39, n_bytes=3822, idle_timeout=10, hard_timeout=30, priority=65535,icmp,in_port=eth1,vlan_tci=0x0000,dl_src=00:00:00:00:00:02,dl_dst=00:00:00:00:00:01,nw_src=10.0.2.2,nw_dst=10.0.1.1,nw_tos=0,icmp_type=0,icmp_code=0 actions=output:eth0
 cookie=0x0, duration=16.975s, table=0, n_packets=35, n_bytes=3430, idle_timeout=10, hard_timeout=30, priority=65535,icmp,in_port=eth0,vlan_tci=0x0000,dl_src=00:00:00:00:00:01,dl_dst=00:00:00:00:00:02,nw_src=10.0.1.1,nw_dst=10.0.2.2,nw_tos=0,icmp_type=8,icmp_code=0 actions=output:eth1
 cookie=0x0, duration=9.421s, table=0, n_packets=1, n_bytes=60, idle_timeout=10, hard_timeout=30, priority=65535,arp,in_port=eth1,vlan_tci=0x0000,dl_src=00:00:00:00:00:02,dl_dst=00:00:00:00:00:01,arp_spa=10.0.2.2,arp_tpa=10.0.1.1,arp_op=1 actions=output:eth0
 cookie=0x0, duration=9.414s, table=0, n_packets=1, n_bytes=60, idle_timeout=10, hard_timeout=30, priority=65535,arp,in_port=eth0,vlan_tci=0x0000,dl_src=00:00:00:00:00:01,dl_dst=00:00:00:00:00:02,arp_spa=10.0.1.1,arp_tpa=10.0.2.2,arp_op=2 actions=output:eth1
 cookie=0x0, duration=1.230s, table=0, n_packets=1, n_bytes=60, idle_timeout=10, hard_timeout=30, priority=65535,arp,in_port=eth0,vlan_tci=0x0000,dl_src=00:00:00:00:00:01,dl_dst=00:00:00:00:00:02,arp_spa=10.0.1.1,arp_tpa=10.0.2.2,arp_op=1 actions=output:eth1
 cookie=0x0, duration=1.226s, table=0, n_packets=1, n_bytes=60, idle_timeout=10, hard_timeout=30, priority=65535,arp,in_port=eth1,vlan_tci=0x0000,dl_src=00:00:00:00:00:02,dl_dst=00:00:00:00:00:01,arp_spa=10.0.2.2,arp_tpa=10.0.1.1,arp_op=2 actions=output:eth0
 cookie=0x0, duration=141.114s, table=0, n_packets=0, n_bytes=0, priority=65000,dl_dst=01:23:20:00:00:01,dl_type=0x88cc actions=CONTROLLER:65535
 
root@s1:/# 


