#!/bin/bash



echo step 1
kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://<kubernetes control plane>:6443

echo step 2
kubectl config set-credentials admin \
    --client-certificate=admin.pem \
    --client-key=admin-key.pem

echo step 3
kubectl config set-context kubernetes-the-hard-way \
    --cluster=kubernetes-the-hard-way \
    --user=admin

echo step 4
kubectl config use-context kubernetes-the-hard-way

echo step 5
kubectl get pods

echo step 6
kubectl get nodes

echo step 7
kubectl version

