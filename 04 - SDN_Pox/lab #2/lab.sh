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
root@controller:/# ./pox/pox.py samples.pretty_log component_a component_b openflow.of_01 -port=6653
POX 0.7.0 (gar) / Copyright 2011-2020 James McCauley, et al.
[component_a   ] component a successfully registered to the POX core
[component_b   ] component b startup: invoke component a print method:
[component_a   ] component a wants to say: hello from component a
[version       ] POX requires one of the following versions of Python: 3.6 3.7 3.8 3.9
[version       ] You are running Python 3.11.
[version       ] If you run into problems, try using a supported version.
[core          ] POX 0.7.0 (gar) is up.
[openflow.of_01] [82-a0-c8-88-b4-4d 1] connected

root@controller:/# exit
