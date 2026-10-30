#!/bin/bash

sudo docker pull onosproject/onos

Using default tag: latest
latest: Pulling from onosproject/onos
d7bfe07ed847: Pull complete 
d25e3bce405f: Pull complete 
447a3ca8727b: Pull complete 
70f6d5a37715: Pull complete 
Digest: sha256:c3d8941030a6bc8a375a49270dc3179cf1f62840b5f037c2d5e09d6dfbe55937
Status: Downloaded newer image for onosproject/onos:latest
docker.io/onosproject/onos:latest

sudo docker run -it -d --name onos-pnet onosproject/onos

8ecba31ca4759949b6c365a536321d7758c1e20a26742c52e524cbfd8278b34a

wireshark -i docker0 -k

 ** (wireshark:11446) 16:05:11.896648 [GUI WARNING] -- QSocketNotifier: Can only be used with threads started with QThread
 ** (wireshark:11446) 16:05:14.427745 [Capture MESSAGE] -- Capture Start ...
 ** (wireshark:11446) 16:05:14.700925 [Capture MESSAGE] -- Capture started
 ** (wireshark:11446) 16:05:14.701116 [Capture MESSAGE] -- File: "/tmp/wireshark_docker0HSY9V3.pcapng"
 ** (wireshark:11446) 16:07:24.386978 [Capture MESSAGE] -- Capture Stop ...
 ** (wireshark:11446) 16:07:24.418090 [Capture MESSAGE] -- Capture stopped.
