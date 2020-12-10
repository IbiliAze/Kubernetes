#!/bin/bash


[ Custom Certificates with CFSSL ]

cfssl gencret -initca CACSR.json | cfssljson -bare ca



[ Certificates ]

kubectl get csr

kubectl get csr pod-csr.web -o yaml

kubectl get csr pod-csr.web -o jsonpath='{.status.certificate}' | base64 --decode #our certificate

kubectl describe csr pod-csr.web

kubectl certificate approve pod-csr.web

kubectl exec testapp-888d4f679-wbz6x -- ls /var/run/secrets/kubernetes.io/serviceaccount





