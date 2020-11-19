#!/bin/bash


[ Services ]

kubectl get svc

kubectl delete svc --all

kubectl annotate service kubernetes externalTrafficPolicy=Local #loadbalancer send traffic to only 1 pod of the node



[ Expose ]

kubectl expose deployment MyDeployment --port 80 --type NodePort

kubectl expose deployment MyDeployment --port 80 --type NodePort --target-port 8080

kubectl expose deployment MyDeployment --port 80 --type LoadBalancer --targetPort 8080



[ Endpoints ]

kubectl get endpoints #cache of IPs attached to services


