#!/bin/bash



[ Applications ]

kubectl describe pod MyPod #see the error reason and message



[ Master Node ]

kubectl get events

kubectl get events -n kube-system

journalctl -u kubelet

sudo more /var/log/syslog | tail 120 | grep kubelet

systemctl status kubelet

systemctl status docker

systemctl stop firewalld

swapoff -a



[ Worker Node ] 

journalctl -u kubelet

sudo more /var/log/syslog | tail 120 | grep kubelet

systemctl status kubelet

systemctl status docker

{New Worker Node}
# Master Node
kubeadm token generate
kubeadm token create $(kubeadm token generate) --ttl 2h --print-join-command #generate a join command for the workers

# Worker Node
#paste the command generate from above



[ Networking ]

{DNS}
kubectl run -it --rm --restart=Never busybox --image=busybox sh
nslookup hostnames
nslookup kubernetes.default
cat /etc/resolv.conf
exit


{kube-proxy}
ps auxw | grep kube-proxy

kubectl exec -it -n kube-system kube-proxy-324ge2 -- sh
iptables-save | grep hostnames
iptables-save | grep KUBE



