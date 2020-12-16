#!/bin/bash

# BETTER TO RUN ON CONTROL PLANE NODE
export CERT_HOSTNAME=$(hostname),$(curl http://169.254.169.254/latest/meta-data/local-ipv4),127.0.0.1,localhost,<other IPs>


#               some IP for Pod, Master   Hostname of Master                    LoadBalancer    LoadBalancer Host
#export CERT_HOSTNAME=10.32.0.1,10.32.0.2,ec2-3-81-58-194.compute-1.amazonaws.com,10.32.0.2,ec2-3-81-58-195.compute-1.amazonaws.com,127.0.0.1,localhost,kubernetes.default #can also add the IP and the hostname of the second and third controllers




cfssl gencert \
    -ca=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    -ca-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca-key.pem \
    -config=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca-config.json \
    -hostname=${CERT_HOSTNAME} \
    -profile=kubernetes \
    kubernetes-csr.json | cfssljson -bare kubernetes

