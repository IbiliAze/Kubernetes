#!/bin/bash



kubectl delete deployment kube-state-metrics created -n monitoring

kubectl delete svc kube-state-metrics -n monitoring

kubectl delete clusterrolebinding prometheus -n monitoring

kubectl delete clusterrole prometheus -n monitoring

kubectl delete service prometheus-service -n monitoring

kubectl delete deployment prometheus-deployment -n monitoring

kubectl delete configmap prometheus-server-conf -n monitoring

kubectl delete namespace monitoring -n monitoring

