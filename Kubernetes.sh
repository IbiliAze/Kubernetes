#!/bin/bash


[HTTP GET]
kubectl get --raw /apis/metric.k8s.io/ | jq

kubectl get namespace

kubectl get nodes

kubectl top nodes

kubectl get pods

kubectl get pods -o wide

kubectl get pods --all-namespaces

kubectl get pods -n MyNameSpace

kubectl get pod MyPod

kubectl get pod MyPod -n MyNameSpace -o yaml

kubectl get pod MyPod -n MyNameSpace -o yaml --export

kubectl describe pod MyPod

kubectl describe pod MyPod -n MyNameSpace

kubectl top pods #resource usage in the default namespace

kubectl top pod MyPod

kubectl top pods -n MyNameSpace

kubectl logs MyPod

kubectl logs MyPod -c MyContainer

kubectl logs MyPod > mylog.log

kubectl get svc

kubectl get hpa




[HTTP POST & PUT]
kubectl create ns MyNameSpace

kubectl apply -f Deployment.yml




[HTTP DELETE]
kubectl delete svc --all

kubectl delete deployment --all

kubectl delete hpa --all

kubectl delete pod MyPod

kubectl delete pod MyPod --now

kubectl delete secret MySecret



[Misc]
kubectl exec -it MyPod123 bash

kubectl exec MyPod123 -- ls /etc/config
