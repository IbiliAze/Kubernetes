#!/bin/bash



kubectl config set-cluster my-kubernetes \
    --certificate-authority=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kube-controller-manager/kube-controller-manager.pem \
    --client-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kube-controller-manager/kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-controller-manager.kubeconfig

kubectl config set-context default \
    --cluster=my-kubernetes \
    --user=system:kube-controller-manager \
    --kubeconfig=kube-controller-manager.kubeconfig

kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig

