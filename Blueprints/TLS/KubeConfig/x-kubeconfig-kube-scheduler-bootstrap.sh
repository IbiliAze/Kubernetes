#!/bin/bash



kubectl config set-cluster my-kubernetes \
    --certificate-authority=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-scheduler.kubeconfig

kubectl config set-credentials system:kube-scheduler \
    --client-certificate=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kube-scheduler/kube-scheduler.pem \
    --client-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kube-scheduler/kube-scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-scheduler.kubeconfig

kubectl config set-context default \
    --cluster=my-kubernetes \
    --user=system:kube-scheduler \
    --kubeconfig=kube-scheduler.kubeconfig

kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig

