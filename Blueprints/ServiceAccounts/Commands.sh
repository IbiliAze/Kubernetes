#!/bin/bash



[ Get Serviceaccounts ] 

kubectl get serviceaccounts

kubectl get sa

kubectl get sa MyAcc -o yaml

kubectl get pods MyPod -o yaml | grep serviceAccount

kubectl get pods -n MyNS MyPod -o yaml | grep serviceAccount

cat /var/run/secrets/kubernetes.io/serviceaccount/token #run on pod to see serviceaccount token



[ Create Serviceaccounts ]

kubectl create serviceaccount MyAcc



[ Delete Serviceaccounts ]

kubectl delete serviceaccount MyAcc

