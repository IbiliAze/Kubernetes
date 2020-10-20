#!/bin/bash


apt install jq

git clone https://github.com/linuxacademy/metrics-server

kubectl apply -f ./metrics-server/deploy/1.8/

sleep 10

kubectl get --raw /api/metrics.k8s.io/ | jq
