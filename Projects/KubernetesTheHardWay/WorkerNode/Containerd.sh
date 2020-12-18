#!/bin/bash




echo step 1
mkdir -p /etc/containerd/

echo step 2
echo "[plugins]
[plugins.cri.containerd]
snapshotter = \"overlayfs\"
[plugins.cri.containerd.default_runtime]
runtime_type = \"io.containerd.runtime.v1.linux\"
runtime_engine = \"/usr/bin/runc\"
runtime_root = \"\"
[plugins.cri.containerd.untrusted_workload_runtime]
runtime_type = \"io.containerd.runtime.v1.linux\"
runtime_engine = \"/usr/bin/runsc\"" > /etc/containerd/config.toml

echo step 3
echo "[Unit]
Description=containerd container runtime
Documentation=https://containerd.io
After=network.target
[Service]
ExecStartPre=/sbin/modprobe overlay
ExecStart=/bin/containerd
Restart=always
RestartSec=5
Delegate=yes
KillMode=process
OOMScoreAdjust=-999
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/containerd.service

echo step 4
systemctl daemon-reload

echo step 5
systemctl start containerd.service

echo steo 6 
systemctl status containerd.service


