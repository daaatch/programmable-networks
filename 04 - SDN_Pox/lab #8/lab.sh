#!/bin/bash

kathara connect controller

root@controller:/# echo "nameserver 8.8.8.8" > /etc/resolv.conf

root@controller:/# pip3 install --break-system-packages networkx
Collecting networkx
  Downloading networkx-3.6.1-py3-none-any.whl.metadata (6.8 kB)
Downloading networkx-3.6.1-py3-none-any.whl (2.1 MB)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.1/2.1 MB 9.4 MB/s  0:00:00
Installing collected packages: networkx
Successfully installed networkx-3.6.1
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.

root@controller:/# python3 /pox/pox.py log.level --DEBUG discovery dijkstra > /tmp/pox.log 2>&1 &
[1] 156

root@controller:/# cat /tmp/pox.log
INFO:dijkstra:dijkstra routing initialized and hooked into topology discovery
DEBUG:core:POX 0.7.0 (gar) going up...
DEBUG:core:Running on CPython (3.11.2/Apr 28 2025 14:11:48)
DEBUG:core:Platform is Linux-6.1.0-41-amd64-x86_64-with-glibc2.36
WARNING:version:POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
WARNING:version:You are running Python 3.11.
WARNING:version:If you run into problems, try using a supported version.
INFO:core:POX 0.7.0 (gar) is up.
DEBUG:openflow.of_01:Listening on 0.0.0.0:6633
INFO:openflow.of_01:[00-00-00-00-00-01 1] connected
INFO:discovery:[SWITCH DISCOVERED] switch DPID: 1
INFO:openflow.of_01:[00-00-00-00-00-02 2] connected
INFO:discovery:[SWITCH DISCOVERED] switch DPID: 2
INFO:discovery:[LINK DISCOVERED] switch 1 (port 2) <---> switch 2 (port 2)
INFO:discovery:[LINK DISCOVERED] switch 2 (port 2) <---> switch 1 (port 2)
INFO:discovery:[HOST DISCOVERED] host (MAC 6e:f5:69:2e:4e:b2) attached to switch 1 (port 1)
INFO:discovery:[HOST DISCOVERED] host (MAC 6e:bc:63:f8:3a:45) attached to switch 2 (port 1)
INFO:dijkstra:[SHORTEST PATH] 6e:bc:63:f8:3a:45 -> 6e:f5:69:2e:4e:b2: [EthAddr('6e:bc:63:f8:3a:45'), 2, 1, EthAddr('6e:f5:69:2e:4e:b2')]
INFO:dijkstra:[FLOW INSTALLED] switch 2: 6e:bc:63:f8:3a:45 -> 6e:f5:69:2e:4e:b2 out port 2
INFO:dijkstra:[FLOW INSTALLED] switch 1: 6e:bc:63:f8:3a:45 -> 6e:f5:69:2e:4e:b2 out port 1
INFO:dijkstra:[SHORTEST PATH] 6e:f5:69:2e:4e:b2 -> 6e:bc:63:f8:3a:45: [EthAddr('6e:f5:69:2e:4e:b2'), 1, 2, EthAddr('6e:bc:63:f8:3a:45')]
INFO:dijkstra:[FLOW INSTALLED] switch 1: 6e:f5:69:2e:4e:b2 -> 6e:bc:63:f8:3a:45 out port 2
INFO:dijkstra:[FLOW INSTALLED] switch 2: 6e:f5:69:2e:4e:b2 -> 6e:bc:63:f8:3a:45 out port 1

root@controller:/# exit
