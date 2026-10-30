#!/bin/bash

# 1. make the setup file executable and run it
chmod +x lab_setup.sh
sudo ./lab_setup.sh

+ ip netns add h1
+ ip netns add h2
+ ovs-vsctl add-br s1
+ ip link add h1-eth0 type veth peer name s1-eth1
+ ip link add h2-eth0 type veth peer name s1-eth2
+ ip link set h1-eth0 netns h1
+ ip link set h2-eth0 netns h2
+ ovs-vsctl add-port s1 s1-eth1
+ ovs-vsctl add-port s1 s1-eth2
+ ovs-vsctl set bridge s1 protocols=OpenFlow10
+ ovs-vsctl set-controller s1 tcp:172.17.0.2:6653
+ ip netns exec h1 ip addr add 10.0.0.1/24 dev h1-eth0
+ ip netns exec h1 ip link set h1-eth0 up
+ ip netns exec h1 ip link set lo up
+ ip netns exec h2 ip addr add 10.0.0.2/24 dev h2-eth0
+ ip netns exec h2 ip link set h2-eth0 up
+ ip netns exec h2 ip link set lo up
+ ip link set s1-eth1 up
+ ip link set s1-eth2 up
+ echo 'Setup completed'
Setup completed

# 2.verify the ONOS container IP
sudo docker ps

CONTAINER ID   IMAGE              COMMAND                  CREATED      STATUS      PORTS                                              NAMES
8ecba31ca475   onosproject/onos   "./bin/onos-service …"   2 days ago   Up 2 days   6640/tcp, 6653/tcp, 8101/tcp, 8181/tcp, 9876/tcp   onos-pnet

sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 8ecba31ca475

172.17.0.2

# 3. test connectivity between hosts (not working as for now)
sudo ip netns exec h1 ping 10.0.0.2

PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
From 10.0.0.1 icmp_seq=1 Destination Host Unreachable
From 10.0.0.1 icmp_seq=2 Destination Host Unreachable
From 10.0.0.1 icmp_seq=3 Destination Host Unreachable
From 10.0.0.1 icmp_seq=4 Destination Host Unreachable
From 10.0.0.1 icmp_seq=5 Destination Host Unreachable
From 10.0.0.1 icmp_seq=6 Destination Host Unreachable
--- 10.0.0.2 ping statistics ---
7 packets transmitted, 0 received, +6 errors, 100% packet loss, time 6146ms
pipe 4

# 4. testing connectivity again after activating the reactive forwarding app in ONOS GUI
sudo ip netns exec h1 ping 10.0.0.2

# 5. RTT difference between first packet (icmp_seq=1 --> time=~20ms) and following ones (icmp_seq=2,3,4,5 --> time=~0.1ms) due to the routing path being computed first
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=21.4 ms
64 bytes from 10.0.0.2: icmp_seq=2 ttl=64 time=0.103 ms
64 bytes from 10.0.0.2: icmp_seq=3 ttl=64 time=0.099 ms
64 bytes from 10.0.0.2: icmp_seq=4 ttl=64 time=0.121 ms
64 bytes from 10.0.0.2: icmp_seq=5 ttl=64 time=0.126 ms
--- 10.0.0.2 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4077ms
rtt min/avg/max/mdev = 0.099/4.375/21.427/8.525 ms

