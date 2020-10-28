#!/bin/bash


[ Create Secrets ]

kubectl create secret generic example-https --from-file=myKey.key --from-file=myKey.cert --from-file-file



[ Get Secrets ]

kubectl get secret testacc-token-694gs

kubectl get secrets example-https -o yaml


[ Delete Secrets ]

kubectl delete secret MySecret
