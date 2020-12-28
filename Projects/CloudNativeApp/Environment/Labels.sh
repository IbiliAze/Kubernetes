#!/bin/bash


echo step 1
export NODE1=gke-cluster-1-default-pool-58457910-5k85
export NODE2=gke-cluster-1-default-pool-58457910-n069
export NODE3=gke-cluster-1-default-pool-58457910-wqgb

echo step 2
kubectl label node ${NODE1} az=zone1
kubectl label node ${NODE2} az=zone2
kubectl label node ${NODE3} az=zone3

echo step 3
kubectl label node ${NODE1} share-type=dedicated
kubectl label node ${NODE2} share-type=dedicated
kubectl label node ${NODE3} share-type=shared


