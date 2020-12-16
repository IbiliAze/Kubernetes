#!/bin/bash



[ Installation ]

echo step 1
cp /home/ec2-user/kube-controller-manager.kubeconfig /var/lib/kubernetes/

echo step 2
echo "[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes
[Service]
ExecStart=/usr/bin/kube-controller-manager \\
--address=0.0.0.0 \\
--cluster-cidr=10.200.0.0/16 \\
--cluster-name=kubernetes \\
--cluster-signing-cert-file=/var/lib/kubernetes/ca.pem \\
--cluster-signing-key-file=/var/lib/kubernetes/ca-key.pem \\
--kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
--leader-elect=true \\
--root-ca-file=/var/lib/kubernetes/ca.pem \\
--service-account-private-key-file=/var/lib/kubernetes/service-account-key.pem \\
--service-cluster-ip-range=10.32.0.0/24 \\
--use-service-account-credentials=true \\
--v=2
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/kube-controller-manager.service

echo step 3
systemctl daemon-reload

echo step 4
systemctl start kube-controller-manager.service

echo step 5
systemctl enable kube-controller-manager

echo step 6
systemctl status kube-controller-manager

