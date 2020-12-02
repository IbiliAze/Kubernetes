#!/bin/bash



kubectl apply -f ENV/Namespace.yml

kubectl apply -f Prometheus/PrometheusConfigMap.yml

kubectl apply -f Prometheus/PrometheusDeployment.yml

kubectl apply -f Prometheus/PrometheusService.yml

kubectl apply -f ENV/ClusterRole.yml

kubectl apply -f ENV/KubeStateMetrics.yml

kubectl apply -f Grafana/GrafanaDeployment.yml

kubectl apply -f Grafana/GrafanaService.yml

