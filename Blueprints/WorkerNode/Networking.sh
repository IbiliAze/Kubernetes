#!/bin/bash



echo step 1
sysctl net.ipv4.conf.all.forwarding=1 #turn on IP forwarding [ temporary command ]

echo step 2
echo "net.ipv4.conf.all.forwarding=1" >> /etc/sysctl.conf #permenant command


