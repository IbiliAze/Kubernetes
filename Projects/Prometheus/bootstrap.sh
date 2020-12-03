#!/bin/bash



kubectl apply -f Environment/Namespace.yml

kubectl apply -f Prometheus/PrometheusConfigMap.yml

kubectl apply -f Prometheus/PrometheusDeployment.yml

kubectl apply -f Prometheus/PrometheusService.yml

kubectl apply -f Environment/ClusterRole.yml

kubectl apply -f Environment/KubeStateMetrics.yml

kubectl apply -f Grafana/GrafanaDeployment.yml

kubectl apply -f Grafana/GrafanaService.yml

