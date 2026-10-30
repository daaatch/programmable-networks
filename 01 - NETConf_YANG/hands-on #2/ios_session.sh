#!/bin/bash

ssh turno.1835365@devnetsandboxiosxec9k.cisco.com

=================================================
Acces restreint aux personnes autorisees
TP NetDevOps - Gere par Ansible - Ne pas modifier
=================================================

SW1#show ip interface brief
Interface              IP-Address      OK? Method Status                Protocol
Vlan1                  unassigned      YES NVRAM  up                    up      
Vlan10                 unassigned      YES unset  administratively down down    
Vlan35                 unassigned      YES unset  down                  down    
Vlan800                192.168.77.254  YES manual down                  down    
Vlan881                unassigned      YES unset  down                  down    
Vlan900                192.168.88.254  YES manual down                  down    
Vlan1050               unassigned      YES unset  down                  down    
GigabitEthernet0/0     10.10.20.66     YES NVRAM  up                    up      
GigabitEthernet1/0/1   unassigned      YES unset  up                    up      
GigabitEthernet1/0/2   10.10.10.1      YES manual up                    up      
GigabitEthernet1/0/3   unassigned      YES unset  administratively down down    
GigabitEthernet1/0/4   10.20.40.1      YES manual up                    up      
GigabitEthernet1/0/5   unassigned      YES unset  administratively down down    
GigabitEthernet1/0/6   unassigned      YES unset  administratively down down    
GigabitEthernet1/0/7   unassigned      YES unset  up                    up      
GigabitEthernet1/0/8   unassigned      YES unset  up                    up      
Loopback0              1.1.1.1         YES manual up                    up      
Loopback10             10.100.10.1     YES manual up                    up      
Loopback20             10.200.20.1     YES manual up                    up      
Loopback83             192.168.83.254  YES manual up                    up     

SW1#show platform software yang-management process
confd            : Running    
nesd             : Running    
syncfd           : Running    
ncsshd           : Running    
dmiauthd         : Running    
nginx            : Running    
ndbmand          : Running    
pubd             : Running    
gnmib            : Running    

SW1#show netconf-yang sessions
R: Global-lock on running datastore
C: Global-lock on candidate datastore
S: Global-lock on startup datastore

Number of sessions : 1

session-id  transport    username             source-host            global-lock  
--------------------------------------------------------------------------------
364         netconf-ssh  turno.1835365        10.10.20.28            None         

SW1#exit
Connection to devnetsandboxiosxec9k.cisco.com closed by remote host.
Connection to devnetsandboxiosxec9k.cisco.com closed.
