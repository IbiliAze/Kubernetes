#!/bin/bash



export KUBERNETES_ADDRESS=10.1.1.1 #private IP of load balancer

for instance in ec2-3-81-58-194.compute-1.amazonaws.com; do #as many worker nodes, or just one
    kubectl config set-cluster my-kubernetes \
    --certificate-authority=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_ADDRESS}:6443 \
    --kubeconfig=${instance}.kubeconfig

    kubectl config set-credentials system:node:${instance} \
    --client-certificate=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kubelet/${instance}.pem \
    --client-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/kubelet/${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=${instance}.kubeconfig

    kubectl config set-context default \
    --cluster=my-kubernetes \
    --user=system:node:${instance} \
    --kubeconfig=${instance}.kubeconfig

    kubectl config use-context default --kubeconfig=${instance}.kubeconfig
done    

