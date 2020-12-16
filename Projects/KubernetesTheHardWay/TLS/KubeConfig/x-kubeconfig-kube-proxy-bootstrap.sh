#!/bin/bash



export KUBERNETES_ADDRESS=10.1.1.1 #private IP of load balancer

kubectl config set-cluster my-kubernetes \
    --certificate-authority=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

kubectl config set-credentials system:kube-proxy \
    --client-certificate=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kube-proxy/kube-proxy.pem \
    --client-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kube-proxy/kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

kubectl config set-context default \
    --cluster=my-kubernetes \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig

