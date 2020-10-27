#!/bin/bash


[ Get Services ]

kubectl get svc



[ Delete Services ]

kubectl delete svc --all



[ Annotate Services ]

kubectl annotate service kubernetes externalTrafficPolicy=Local #loadbalancer send traffic to only 1 pod of the node


