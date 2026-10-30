#!/bin/bash

kathara check
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                  System Check                                   │
└─────────────────────────────────────────────────────────────────────────────────┘
Current Manager is:             Docker (Kathara)
Manager version is:             20.10.24+dfsg1
Python version is:              3.13.13 (main, Apr  8 2026, 09:49:30) [GCC 11.4.0]
Kathara version is:             3.8.3
Operating System version is:    Linux-6.1.0-41-amd64-x86_64
[Deploying devices]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1/1
[Deleting devices]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1/1
✓ Container run successfully.

kathara list
TIMESTAMP: 2026-10-12 17:49:29.997480                             
╔═════════════════════════════════════════════════════════════════════════════════╗
║                                No Devices Found                                 ║
╚═════════════════════════════════════════════════════════════════════════════════╝

kathara lstart
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              Starting Network Scenario                          │
└─────────────────────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────────────────────┐
│ Name: lab #1                                                                    │
│ Description: three hosts with three routers in line                             │
└─────────────────────────────────────────────────────────────────────────────────┘
[Deploying collision domains]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6/6
[Deploying devices]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6/6

kathara exec h1 -- ping 192.168.2.2
PING 192.168.2.2 (192.168.2.2) 56(84) bytes of data.
64 bytes from 192.168.2.2: icmp_seq=1 ttl=62 time=0.838 ms
64 bytes from 192.168.2.2: icmp_seq=2 ttl=62 time=2.54 ms
64 bytes from 192.168.2.2: icmp_seq=3 ttl=62 time=1.63 ms
64 bytes from 192.168.2.2: icmp_seq=4 ttl=62 time=1.68 ms
64 bytes from 192.168.2.2: icmp_seq=5 ttl=62 time=1.74 ms

kathara exec h1 -- ping 192.168.3.2
PING 192.168.3.2 (192.168.3.2) 56(84) bytes of data.
64 bytes from 192.168.3.2: icmp_seq=1 ttl=62 time=2.15 ms
64 bytes from 192.168.3.2: icmp_seq=2 ttl=62 time=1.86 ms
64 bytes from 192.168.3.2: icmp_seq=3 ttl=62 time=1.89 ms
64 bytes from 192.168.3.2: icmp_seq=4 ttl=62 time=1.55 ms
64 bytes from 192.168.3.2: icmp_seq=5 ttl=62 time=1.91 ms

kathara exec h2 -- ping 192.168.1.2
PING 192.168.1.2 (192.168.1.2) 56(84) bytes of data.
64 bytes from 192.168.1.2: icmp_seq=1 ttl=62 time=0.861 ms
64 bytes from 192.168.1.2: icmp_seq=2 ttl=62 time=1.42 ms
64 bytes from 192.168.1.2: icmp_seq=3 ttl=62 time=1.81 ms
64 bytes from 192.168.1.2: icmp_seq=4 ttl=62 time=1.74 ms
64 bytes from 192.168.1.2: icmp_seq=5 ttl=62 time=1.43 ms

kathara exec h2 -- ping 192.168.3.2
PING 192.168.3.2 (192.168.3.2) 56(84) bytes of data.
64 bytes from 192.168.3.2: icmp_seq=1 ttl=62 time=1.53 ms
64 bytes from 192.168.3.2: icmp_seq=2 ttl=62 time=1.89 ms
64 bytes from 192.168.3.2: icmp_seq=3 ttl=62 time=2.05 ms
64 bytes from 192.168.3.2: icmp_seq=4 ttl=62 time=1.71 ms
64 bytes from 192.168.3.2: icmp_seq=5 ttl=62 time=1.85 ms

kathara exec h3 -- ping 192.168.1.2
PING 192.168.1.2 (192.168.1.2) 56(84) bytes of data.
64 bytes from 192.168.1.2: icmp_seq=1 ttl=62 time=1.11 ms
64 bytes from 192.168.1.2: icmp_seq=2 ttl=62 time=1.92 ms
64 bytes from 192.168.1.2: icmp_seq=3 ttl=62 time=1.94 ms
64 bytes from 192.168.1.2: icmp_seq=4 ttl=62 time=1.97 ms
64 bytes from 192.168.1.2: icmp_seq=5 ttl=62 time=1.97 ms

kathara exec h3 -- ping 192.168.2.2
PING 192.168.2.2 (192.168.2.2) 56(84) bytes of data.
64 bytes from 192.168.2.2: icmp_seq=1 ttl=62 time=1.19 ms
64 bytes from 192.168.2.2: icmp_seq=2 ttl=62 time=1.95 ms
64 bytes from 192.168.2.2: icmp_seq=3 ttl=62 time=2.10 ms
64 bytes from 192.168.2.2: icmp_seq=4 ttl=62 time=1.99 ms
64 bytes from 192.168.2.2: icmp_seq=5 ttl=62 time=1.96 ms

kathara lclean
┌─────────────────────────────────────────────────────────────────────────────────┐
│                            Stopping Network Scenario                            │
└─────────────────────────────────────────────────────────────────────────────────┘
[Deleting devices]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6/6
[Deleting collision domains]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6/6

