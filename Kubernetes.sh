#!/bin/bash


[HTTP GET]
kubectl get --raw /apis/metric.k8s.io/ | jq

kubectl version

kubectl version --short

kubectl get namespace

kubectl get nodes

kubectl top nodes

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

kubectl describe nodes

kubectl describe pods

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

kubectl get endpoints MyEndpoint

kubectl get ep MyEndpoint

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

kubectl run nginx --image=nginx

kubectl port-forward MyPod 8081:80

kubectl expose deployment MyDeployment --port 80 --type NodePort




[HTTP DELETE]
kubectl delete svc --all

kubectl delete deployment --all

kubectl delete hpa --all

kubectl delete pod MyPod

kubectl delete pod MyPod --now

kubectl delete secret MySecret




[Upgrade Kubernetes Cluster]
sudo apt-mark unhold hubeadm kubelet; sudo apt install -y kubeadm=1.18.5-00; sudo apt-mark hold kubeadm #upgrade

sudo kubeadm upgrade plan #show the available updates

sudo kubeadm upgrade apply v1.18.5

sudo apt-mark unhold kubelet kubectl; sudo apt install -y kubectl=1.18.5-00 kubelet=1.18.5-00; sudo apt-mark hold kubelet kubectl

kubectl get nodes #verify node version

kubectl version --short #verify master version




[Misc]
kubectl exec -it MyPod123 bash

kubectl exec MyPod123 -- ls /etc/config

kubectl edit deployment MyDeployment
