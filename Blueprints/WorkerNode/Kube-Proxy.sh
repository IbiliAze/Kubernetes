#!/bin/bash




echo step 1
mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig

echo step 2
echo "kind: KubeProxyConfiguration
apiVersion: kubeproxy.config.k8s.io/v1alpha1
clientConnection:
  kubeconfig: "/var/lib/kube-proxy/kubeconfig"
mode: "iptables"
clusterCIDR: "10.200.0.0/16"" > /var/lib/kube-proxy/kube-proxy-config.yaml

echo step 3
echo "[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/kubernetes/kubernetes
[Service]
ExecStart=/usr/local/bin/kube-proxy \\
--config=/var/lib/kube-proxy/kube-proxy-config.yaml
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/kube-proxy.service

echo step 4
systemctl daemon-reload

echo step 5
systemctl enable containerd kubelet kube-proxy

echo step 6
systemctl start containerd kubelet kube-proxy

echo step 7
sudo systemctl status containerd kubelet kube-proxy



