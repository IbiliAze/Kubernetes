#!/bin/bash



[ Nodes ]

kubectl get nodes

kubectl top nodes

kubectl describe nodes

kubectl delete node MyNode

kubectl label node MyNode key1=value1



[ Kubernetes ]

kubectl get --raw /apis/metric.k8s.io/ | jq

kubectl version

kubectl version --short



[ Config ]

kubectl config view #kubernetes config

kubectl config current-context

kubectl config set-credentials MyUser  --username=MyUser --password=MyPassword



[ Deployments ]

kubectl describe deployment MyDeployment

kubectl delete deployment --all

kubectl create deployment --image nginx mynginx

kubectl apply -f Deployment.yml

kubectl replace -f Deployment.yml

kubectl scale deployment MyDeployment --replicas=5

kubectl expose deployment MyDeployment --port 80 --type NodePort

kubectl expose deployment MyDeployment --port 80 --type NodePort --target-port 80

kubectl create -f Deployment.yml --record #keep revision history



[ Security ]

cat ~/.kube/config #PKI (authentication) information

curl localhost/api/v1/namespaces/testns/services #run on pod to see privilege success/fails

kubectl config set-credentials MyUser  --username=MyUser --password=MyPassword



[ Networking ]

kubectl describe networkpolicies MyPolicy

kubectl get networkpolicies

kuebadm token list #list current tokens before adding to an existing cluster

docker inspect --format '{ .State.Pid }' MyPod #get container process ID

nsenter -t MyContainerPid -n ip addr #get pod IP address

kubectl get deployment -n kube-system #other services, including DNS

kubectl get services -n kube-system #get DNS server IP address



[ Upgrade Kubernetes Cluster ]

sudo apt-mark unhold hubeadm kubelet; sudo apt install -y kubeadm=1.18.5-00; sudo apt-mark hold kubeadm #upgrade

sudo kubeadm upgrade plan #show the available updates

sudo kubeadm upgrade apply v1.18.5

sudo apt-mark unhold kubelet kubectl; sudo apt install -y kubectl=1.18.5-00 kubelet=1.18.5-00; sudo apt-mark hold kubelet kubectl

kubectl get nodes #verify node version

kubectl version --short #verify master version



[ Upgrade Node OS ]

kubectl drain MyNode --ignore-daemonsets #before OS update

kubectl uncordon MyNode #put node back into service



[ Upgrade Patch ]

kubectl patch deployment MyDeployment -p '{"spec":{"minReadySeconds": 10}}' #for visuals

kubectl rollout undo MyDeployment

kubectl rollout undo MyDeployment --to-revision=1

kubectl rollout history deployment MyDeployment

kubectl rollout history deployment MyDeployment --revision=2



[ Configure & Comission ]

kubectl exec -it MyPod123 bash

kubectl exec MyPod123 -- ls /etc/config

kubectl exec -t testapp-888d4f679-cpf4f -- cat /etc/resolv.conf #see the pod DNS entry

kubectl exec -it testapp-888d4f679-cpf4f -- nslookup kubernetes #see the kubernetes service DNS name

kubectl edit deployment MyDeployment

kubectl edit ingress MyIngress

kubectl set image MyDeployment MyContainer ibiliaze/engine5:latest --record

kubectl set image MyDeployment MyContainer ibiliaze/engine5:latest --record --v #verbose

kubectl run nginx --image=nginx

kubectl expose deployment MyDeployment --port 80 --type NodePort

kubectl expose deployment MyDeployment --port 80 --type NodePort --target-port 80

kubectl port-forward MyPod 8081:80



[ Endpoints ]

kubectl get endpoints MyEndpoint

kubectl get ep MyEndpoint



[ Namespace ]

kubectl create ns MyNameSpace

kubectl get namespace



[ Labels ]

kubectl label node MyNode key1=value1



[ ConfigMap ]

kubectl create configmap MyConfigMap --from-literal=key1=value1 --from-literal=key2-value2



[ Token ]

kubeadm token generate #run on master

kubeadm token create MyToken --ttl 2h --print-join-command #run after above




