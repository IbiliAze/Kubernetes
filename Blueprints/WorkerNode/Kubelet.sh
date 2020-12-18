#!/bin/bash



echo step 1
export HOSTNAME=$(hostname)

echo step 2
mv ${HOSTNAME}-key.pem ${HOSTNAME}.pem /var/lib/kubelet/
mv ${HOSTNAME}.kubeconfig /var/lib/kubelet/kubeconfig
mv ca.pem /var/lib/kubernetes/

echo step 3
echo "kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: \"/var/lib/kubernetes/ca.pem\"
authorization:
  mode: Webhook
clusterDomain: \"cluster.local\"
clusterDNS:
  - \"10.32.0.10\"
runtimeRequestTimeout: \"15m\"
tlsCertFile: \"/var/lib/kubelet/${HOSTNAME}.pem\"
tlsPrivateKeyFile: \"/var/lib/kubelet/${HOSTNAME}-key.pem\"" > /var/lib/kubelet/kubelet-config.yaml

echo step 4
echo "[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=containerd.service
Requires=containerd.service
[Service]
ExecStart=/usr/local/bin/kubelet \\
--config=/var/lib/kubelet/kubelet-config.yaml \\
--container-runtime=remote \\
--container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \\
--image-pull-progress-deadline=2m \\
--kubeconfig=/var/lib/kubelet/kubeconfig \\
--network-plugin=cni \\
--register-node=true \\
--v=2 \\
--hostname-override=${HOSTNAME} \\
--allow-privileged=true
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/kubelet.service

echo step 5 
systemctl daemon-reload

echo step 6
systemctl start containerd.service

echo steo 7
systemctl status containerd.service



