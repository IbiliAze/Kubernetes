#!/bin/bash


cfssl gencert \
    -ca=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca.pem \
    -ca-key=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca-key.pem \
    -config=/home/ibi/Documents/Git/Kubernetes/Blueprints/TLS/Certificates/ca/ca-config.json \
    -profile=kubernetes \
    kube-proxy-csr.json | cfssljson -bare kube-proxy

