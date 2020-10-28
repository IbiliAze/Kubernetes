#!/bin/bash


kubectl config set-credentials myuser --username=myuser --password=cisco

kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous
