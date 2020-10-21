#!/bin/bash


echo label 1a
kubectl label node gke-cluster-1-default-pool-01979696-4c5b az=zone1

echo label 1b
kubectl label node gke-cluster-1-default-pool-01979696-4c5b st=dedicated


echo label 2a
kubectl label node gke-cluster-1-default-pool-01979696-6758 az=zone2

echo label 2b
kubectl label node gke-cluster-1-default-pool-01979696-6758 st=shared
