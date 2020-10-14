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

kubectl get pods --show-labels

kubectl get pods -l app=testapp

kubectl get pods -l environment!=prod

kubectl get pods -l 'environment in (prod,dev)'

kubectl get pods -l app=testapp,environment=prod

kubectl get pod MyPod

kubectl get pod MyPod -n MyNameSpace -o yaml

kubectl get pod MyPod -n MyNameSpace -o yaml --export

kubectl describe pod MyPod

kubectl describe pod MyPod -n MyNameSpace

kubectl describe networkpolicies MyPolicy

kubectl top pods #resource usage in the default namespace

kubectl top pod MyPod

kubectl top pods -n MyNameSpace

kubectl logs MyPod

kubectl logs MyPod -c MyContainer

kubectl logs MyPod > mylog.log

kubectl get svc

kubectl get endpoints MyService

kubectl get ep MyService

kubectl get hpa

kubectl get job

kubectl get cronjob

kubectl get networkpolicies

kubectl rollout history MyDeployment

kubectl rollout history MyDeployment --revision=2




[HTTP POST & PUT]
kubectl create ns MyNameSpace

kubectl apply -f Deployment.yml

kubectl set image MyDeployment MyContainer ibiliaze/engine5:latest --record

kubectl rollout undo MyDeployment

kubectl rollout undo MyDeployment --to-revision=1




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

kubectl edit deployment MyDeployment
