#!/bin/bash


kubectl get pods

kubectl get pods -o wide

kubectl get pods -o custom-columns=POD:metadata.name,NODE:spec.nodeName --sort-by spec.nodeName -n kube-system

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

kubectl describe pods

kubectl describe pod MyPod

kubectl describe pod MyPod -n MyNameSpace

kubectl top pods #resource usage in the default namespace

kubectl top pod MyPod

kubectl top pods -n MyNameSpace

kubectl logs MyPod

kubectl logs MyPod -c MyContainer

kubectl logs MyPod > mylog.log

kubectl delete pod MyPod

kubectl delete pod MyPod --now


