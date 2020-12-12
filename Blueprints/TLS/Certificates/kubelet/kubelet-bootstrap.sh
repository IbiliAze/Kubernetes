#!/bin/bash


export WORKER0_HOST=ec2-3-81-58-194.compute-1.amazonaws.com
export WORKER0_IP=3.81.58.194 #private IP recommended

cfssl gencert \
    -ca=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    -ca-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca-key.pem \
    -config=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca-config.json \
    -hostname=${WORKER0_IP},${WORKER0_HOST} \
    -profile=kubernetes \
    ${WORKER0_HOST}-csr.json | cfssljson -bare ${WORKER0_HOST}




