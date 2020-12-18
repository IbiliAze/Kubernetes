#!/bin/bash



kubectl describe networkpolicies MyPolicy

kubectl get networkpolicies

kuebadm token list #list current tokens before adding to an existing cluster

docker inspect --format '{{ .State.Pid }}' ContainerId #get container process ID
nsenter -n -t MyContainerPid ip addr #-n=network namespace -> empty=pid NS, -t=target, run a command within the processes' network namespace

sudo iptables-save | grep KUBE #iptables rules



[ DNS ]

kubectl get pods -n kube-system
kubectl get deployment -n kube-system #other services, including DNS
kubectl get services -n kube-system #get DNS server IP address
kubectl exec -it node-54fdfb47f8-6w7vk -- cat /etc/resolv.conf #should return the same DNS server IP as the kube-dns service above

kubectl exec -it node-54fdfb47f8-6w7vk -- apt-get install dnsutils -y
kubectl exec -it node-54fdfb47f8-6w7vk -- nslookup kubernetes #get the domain name of the kubernetes ClusterIP service
kubectl exec -it node-54fdfb47f8-6w7vk -- nslookup 10-4-2-5.default.pod.cluster.local #nslookup pods
kubectl exec -it node-54fdfb47f8-6w7vk -- nslookup metrics-server.default.svc.cluster.local #nslookup services

kubectl logs coredns-4234b2342424-2vfv -n kube-system



[ netshoot ] 
kubectl run netshoot --image nikolaka/netshoot



