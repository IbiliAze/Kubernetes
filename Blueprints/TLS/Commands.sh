#!/bin/bash


[ Custom Certificates with CFSSL ]

#CSR
cat <<EOF | cfssl genkey - | cfssljson -bare server
{
    "hosts": [
        "my-svc.my-namespace.svc.cluster.local",
        "my-pod.my-namespace.pod.cluster.local",
        "172.168.0.24",
        "10.0.34.2"
    ],
    "CN": "my-pod.my-namespace.pod.cluster.local",
    "key": {
        "algo": "ecdsa",
        "size": 256
    }
}
EOF 



[ Certificates ]

kubectl get csr

kubectl get csr pod-csr.web -o yaml

kubectl get csr pod-csr.web -o jsonpath='{.status.certificate}' | base64 --decode #our certificate

kubectl describe csr pod-csr.web

kubectl certificate approve pod-csr.web

kubectl exec testapp-888d4f679-wbz6x -- ls /var/run/secrets/kubernetes.io/serviceaccount





