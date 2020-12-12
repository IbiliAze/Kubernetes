#!/bin/bash



kubectl config set-cluster my-kubernetes \
    --certificate-authority=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=admin.kubeconfig

kubectl config set-credentials admin \
    --client-certificate=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/admin/admin.pem \
    --client-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/admin/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

kubectl config set-context default \
    --cluster=my-kubernetes \
    --user=admin \
    --kubeconfig=admin.kubeconfig

kubectl config use-context default --kubeconfig=admin.kubeconfig

