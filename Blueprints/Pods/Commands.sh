#!/bin/bash


[ Get Pods ]

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

kubectl get pods --field-selector status.phase=Running #filter

kubectl get pods --field-selector metadata.namespace=default

kubectl get pods --field-selector status.phase=Running,metadata.namespace=default



[ Describe Pods ]

kubectl describe pods

kubectl describe pod MyPod

kubectl describe pod MyPod -n MyNameSpace



[ Top Pods ]

kubectl top pods #resource usage in the default namespace

kubectl top pod MyPod

kubectl top pods -n MyNameSpace

kubectl top pods --sort-by cpu



[ Logs ]

kubectl logs MyPod

kubectl logs MyPod -c MyContainer

kubectl logs MyPod > mylog.log



[ Delete ]

kubectl delete pod MyPod

kubectl delete pod MyPod --now



[ Port-Forward]

kubectl port-forward MyPod 8081:80



[ Static Pods ]

sudo cd /etc/kubernetes/manifest/ #default manifest path for kubeadm on the worker node
sudo vim my-static-pod.yml #kubelet will automatically check that directory and create the static pod
kubectl get pods #the pod shown will the Mirror Pod

sudo systemctl restart kubelet #speed up the step above





