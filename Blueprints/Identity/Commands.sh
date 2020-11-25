#!/bin/bash




[ Users ]

kubectl config set-credentials myuser --username=myuser --password=cisco



[ Cluster Roles ]

kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous
