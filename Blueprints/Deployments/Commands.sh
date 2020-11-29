#!/bin/bash



[ Deployments ]

kubectl describe deployment MyDeployment

kubectl delete deployment --all

kubectl create deployment --image nginx mynginx

kubectl apply -f Deployment.yml

kubectl replace -f Deployment.yml

kubectl scale deployment MyDeployment --replicas=5

kubectl expose deployment MyDeployment --port 80 --type NodePort

kubectl expose deployment MyDeployment --port 80 --type NodePort --target-port 80

kubectl create -f Deployment.yml --record #keep revision history



[ Patch ]

kubectl rollout status deployment MyDeployment

kubectl patch deployment MyDeployment -p '{"spec":{"minReadySeconds": 10}}' #for visuals

kubectl rollout undo MyDeployment

kubectl rollout undo MyDeployment --to-revision=1

kubectl set image deployment MyDeployment nginx=nginx:1.19.2 #another way to update the image

kubectl set image deployment MyDeployment nginx=nginx:1.19.2 --record #keep deployment hostory

kubectl rollout history deployment MyDeployment

kubectl rollout history deployment MyDeployment --revision=2

