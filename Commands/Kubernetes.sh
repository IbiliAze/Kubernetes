#!/bin/bash



[ Nodes ]

kubectl get nodes

kubectl top nodes

kubectl describe nodes

kubectl delete node MyNode

kubectl label node MyNode key1=value1

kubectl drain myNode

kubectl drain myNode --ignore-daemonsets #--ignore-daemonsets=ignore pods tied to each node (kube-system pods)

kubectl drain gke-cluster-1-default-pool-cb7a459d-ccnf --ignore-daemonsets --force #will delete the pod with no deployment

kubectl uncordon myNode #run pods on the nodes again, e.g after an K8s version upgrade



[ Kubernetes ]

kubeadm init --config myconfig.yml #initialise a cluster from a YAML file

kubectl get --raw /apis/metric.k8s.io/ | jq

kubectl version

kubectl version --short

kubectl get componentstatus

kubectl get pods -n kube-system

kubectl get pods -n kube-system -o custom-columns=POD:metadata.name,NODE:spec.nodeName --sort-by spec.nodeName #--sort-by=JSON path expression (-o json)

kubectk get pods -n kube-system --selector k8s-app=prometheus-to-sd #--selector=match labels

kubectl get endpoints kube-scheduler -n kube-system -o yaml #master control plane node elector



[ Config ]

kubeadm init --config myconfig.yml #initialise a cluster from a YAML file

kubectl config view #kubernetes config

kubectl config current-context

kubectl config set-credentials MyUser  --username=MyUser --password=MyPassword



[ Security ]

cat ~/.kube/config #PKI (authentication) information

curl localhost/api/v1/namespaces/testns/services #run on pod to see privilege success/fails


{Adding a kubectl user}
# On the Master
kubectl config set-credentials MyUser  --username=MyUser --password=MyPassword #add a user to manage the cluster with kubectl
kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin  --user=system:anonymous
scp /etc/kubernetes/pki/ca.crt ibi@myaddress:~/
# On the user
kubectl config set-cluster kubernetes --server=https://35.184.82.142:6443 --certificate-authority=~/ca.crt --embed-certs=true
kubectl config set-credentials MyUser  --username=MyUser --password=MyPassword
kubectl config set-context kubernetes --cluster=kubernetes --user=MyUser --namespace=default
kubectl config use-context kubernetes
kubectl get nodes


{Service Accounts}
kubectl create ns my-ns
kubectl run test --image=chadmcrowell/kubectl-proxy -n my-ns
kubectl exec -it test -n my-ns sh
curl localhost:8001 #should be a forbidden request
exit
kubectl get sa



[ Networking ]

kubectl describe networkpolicies MyPolicy

kubectl get networkpolicies

kuebadm token list #list current tokens before adding to an existing cluster

docker inspect --format '{{ .State.Pid }}' ContainerId #get container process ID
nsenter -n -t MyContainerPid ip addr #-n=network namespace -> empty=pid NS, -t=target, run a command within the processes' network namespace

sudo iptables-save | grep KUBE #iptables rules


{DNS}
kubectl get pods -n kube-system
kubectl get deployment -n kube-system #other services, including DNS
kubectl get services -n kube-system #get DNS server IP address
kubectl exec -it node-54fdfb47f8-6w7vk -- cat /etc/resolv.conf #should return the same DNS server IP as the kube-dns service above

kubectl exec -it node-54fdfb47f8-6w7vk -- apt-get install dnsutils -y
kubectl exec -it node-54fdfb47f8-6w7vk -- nslookup kubernetes #get the domain name of the kubernetes ClusterIP service
kubectl exec -it node-54fdfb47f8-6w7vk -- nslookup 10-4-2-5.default.pod.cluster.local #nslookup pods
kubectl exec -it node-54fdfb47f8-6w7vk -- nslookup metrics-server.default.svc.cluster.local #nslookup services

kubectl logs coredns-4234b2342424-2vfv -n kube-system


{netshoot}
kubectl run netshoot --image nikolaka/netshoot



[ Upgrade Cluster ] 

{kubeadm}
#Master Node
sudo apt update -y
sudo apt install -y kubeadm=1.19.2-00 --allow-change-held-packages #upgrade the kubeadm package
kubectl drain MyControlPlaneNode --ignore-daemonsets #before OS update
kubectl drain MyWorkerNode --ignore-daemonsets
sudo kubeadm upgrade plan #show the available updates
sudo kubeadm upgrade apply v1.19.2

#Worker Node
sudo apt update -y
sudo apt install -y kubeadm=1.19.2-00 --allow-change-held-packages
sudo kubeadm upgrade node


{kubectl & kubelet}
#Master Node
sudo apt update -y
sudo apt install -y kubelet=1.19.2-00 kubectl=1.19.2-00 --allow-change-held-packages
sudo systemctl daemon-reload
sudo systemctl restart kubelet
kubectl get nodes

#Worker Node
sudo apt update -y
sudo apt install -y kubelet=1.19.2-00 kubectl=1.19.2-00 --allow-change-held-packages
sudo systemctl daemon-reload
sudo systemctl restart kubelet


{Final uncordoning}
#Master Node
kubectl uncordon MyControlPlaneNode
kubectl uncordon MyWorkerNode



[ Patch ]

kubectl rollout status deployment MyDeployment

kubectl patch deployment MyDeployment -p '{"spec":{"minReadySeconds": 10}}' #for visuals

kubectl rollout undo MyDeployment

kubectl rollout undo MyDeployment --to-revision=1

kubectl set image deployment MyDeployment nginx=nginx:1.19.2 #another way to update the image

kubectl set image deployment MyDeployment nginx=nginx:1.19.2 --record #will keep deployment hostory

kubectl rollout history deployment MyDeployment

kubectl rollout history deployment MyDeployment --revision=2



[ Configure & Comission ]

kubectl exec -it MyPod123 bash

kubectl exec MyPod123 -- ls /etc/config

kubectl exec -it testapp-888d4f679-cpf4f -- cat /etc/resolv.conf #see the pod DNS entry

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



[ etcd ]

etcdctl snapshot save #backup

etcdctl snapshot restore #creates a temprary logical cluster












