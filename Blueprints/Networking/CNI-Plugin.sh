#!/bin/bash



echo step 1
sysctl net.ipv4.conf.all.forwarding=1 #turn on IP forwarding [ temporary command ]

echo step 2
echo "net.ipv4.conf.all.forwarding=1" >> /etc/sysctl.conf #permenant command

echo step 3
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n'&)env.IPALLOC_RANGE=10.200.0.0/16"

echo step 4
kubectl get pods -n kube-system | grep weave-net



