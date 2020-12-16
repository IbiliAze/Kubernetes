#!/bin/bash



[ Installation ] 

echo step 1
cp kube-scheduler.kubeconfig /var/lib/kubernetes/

echo step 2
echo "apiVersion: componentconfig/v1alpha1
kind: KubeSchedulerConfiguration
clientConnection:
  kubeconfig: "/var/lib/kubernetes/kube-scheduler.kubeconfig"
leaderElection:
  leaderElect: true" > /etc/kubernetes/config/kube-scheduler.yaml

echo step 3
echo "[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes
[Service]
ExecStart=/usr/bin/kube-scheduler \\
--config=/etc/kubernetes/config/kube-scheduler.yaml \\
--v=2
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/kube-scheduler.service

echo step 4
systemctl daemon-reload

echo step 5
systemctl enable kube-apiserver kube-controller-manager kube-scheduler etcd

echo step 6
systemctl start kube-scheduler

echo step 7
systemctl status kube-apiserver.service kube-scheduler.service kube-controller-manager.service etcd

echo step 8
kubectl get componentstatuse






