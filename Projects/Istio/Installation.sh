#!/bin/bash



echo step 1
curl -L https://istio.io/downloadIstio | sh -

echo step 2
mv istio-1.8.1/bin/istioctl /usr/bin

echo step 3
istioctl install --set profile=demo -y

echo step 4
kubectl apply -f istio-1.8.1/samples/bookinfo/platform/kube/bookinfo.yaml

echo step 5
kubectl get pods -n istio-system

echo step 6
kubectl get svc -n istio-system

echo step 7
kubectl apply -f <(istioctl kube-inject -f sam)



