#!/bin/bash

# close running processes in the kathara container environment
kathara connect controller

# kill the currently running POX process
root@controller:/# pkill -f pox.py

# force python to use UTF-8 encoding
root@controller:/# export PYTHONIOENCODING=utf-8

# call the component
root@controller:/# ./pox/pox.py samples.pretty_log openflow.of_01 -port=6653 mac_swap
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[mac_swap      ] MAC swapping component loaded
[version       ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version       ] You are running Python 3.11.
[version       ] If you run into problems, try using a supported version.
[core          ] POX 0.7.0 (gar) is up.
[openflow.of_01] [be-ce-2d-f4-3e-46 1] connected

# run the send/receive script in h1
kathara connect h1

root@h1:/# cd home

root@h1:/home# ls
sendARP.py  sendIP.py  send_receive.py

root@h1:/home# python3 send_receive.py
1 packet sent

root@h1:/home# exit

root@controller:/# ./pox/pox.py samples.pretty_log openflow.of_01 -port=6653 mac_swap
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[mac_swap      ] MAC swapping component loaded
[version       ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version       ] You are running Python 3.11.
[version       ] If you run into problems, try using a supported version.
[core          ] POX 0.7.0 (gar) is up.
[openflow.of_01] [be-ce-2d-f4-3e-46 1] connected
[mac_swap      ] [MAC SWAPPER] original -> source: 00:00:00:00:00:01, destination: 11:22:33:44:55:66
[mac_swap      ] [MAC SWAPPER] swapped  -> source: 11:22:33:44:55:66, destination: 00:00:00:00:00:01
[core          ] Going down...
[openflow.of_01] [be-ce-2d-f4-3e-46 1] disconnected
[core          ] Down.

root@controller:/# exit
