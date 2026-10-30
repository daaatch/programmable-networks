#!/bin/bash

set -x  # print commands as they execute

# 1. create host namespaces
ip netns add h1
ip netns add h2

# 2. create open vswitch bridge
ovs-vsctl add-br s1

# 3. create virtual ethernet pairs
ip link add h1-eth0 type veth peer name s1-eth1
ip link add h2-eth0 type veth peer name s1-eth2

# 4. move host ports into namespaces
ip link set h1-eth0 netns h1
ip link set h2-eth0 netns h2

# 5. connect switch ports to OVS
ovs-vsctl add-port s1 s1-eth1
ovs-vsctl add-port s1 s1-eth2

# 6. set up openflow controller (ONOS)
ovs-vsctl set bridge s1 protocols=OpenFlow10
ovs-vsctl set-controller s1 tcp:172.17.0.2:6653

# 7. configure host IP addresses & bring links UP
ip netns exec h1 ip addr add 10.0.0.1/24 dev h1-eth0
ip netns exec h1 ip link set h1-eth0 up
ip netns exec h1 ip link set lo up

ip netns exec h2 ip addr add 10.0.0.2/24 dev h2-eth0
ip netns exec h2 ip link set h2-eth0 up
ip netns exec h2 ip link set lo up

ip link set s1-eth1 up
ip link set s1-eth2 up

echo "Setup completed"
