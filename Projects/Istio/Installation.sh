#!/bin/bash



echo step 1
wget https://github.com/istio/istio/releases/download/1.0.6/istio-1.0.6-linux.tar.gz

echo step 2
tar -xvf istio-1.0.6-linux.tar.gz

echo step 3
mv istio-1.0.6/bin/istioctl /usr/bin

echo step 4
kubectl apply -f istio-1.0.6/install/kubernetes/istio-demo.yaml

echo step 5
kubectl get pods -n istio-system

echo step 6
kubectl get svc -n istio-system

echo step 7
kubectl apply -f <(istioctl kube-inject -f sam)



