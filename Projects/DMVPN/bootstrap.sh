#!/bin/bash


kubectl apply -f Environment/ConfigMap.yml

kubectl apply -f Environment/Secret.yml

kubectl apply -f MongoDB/MongoStorageClass.yml

kubectl apply -f MongoDB/MongoPersistentVolumeClaim.yml

kubectl apply -f MongoDB/MongoDeployment.yml

kubectl apply -f MongoDB/MongoService.yml

kubectl apply -f NodeJS/NodeDeployment.yml

kubectl apply -f NodeJS/NodeService.yml

