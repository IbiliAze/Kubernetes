#!/bin/bash



[ Installation ]

sudo su

echo step 1
mkdir kube-downloads; cd kube-downloads
mkdir -p /etc/kubernetes/config

echo step 2 
wget -q --show-progress --https-only --timestamping \
    "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kube-apiserver" \
    "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kube-controller-manager" \
    "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kube-scheduler" \
    "https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubectl" 

echo step 3
chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl

echo step 4
mv kube* /usr/bin

echo step 5
mkdir /var/lib/kubernetes

echo step 6
cd ~
cp \
ca.pem \
ca-key.pem \
kubernetes-key.pem \
kubernetes.pem \
service-account.pem \
service-account-key.pem \
EncryptionConfig.yml \
/var/lib/kubernetes

echo step 7
export INTERNAL_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4) #different for multiple controllers

echo step 8
export CONTROLLER0_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4) #same for all controllers, as this is the first control server
export CONTROLLER1_IP=$(<the other control node>)

echo step 9
echo "[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes
[Service]
ExecStart=/usr/bin/kube-apiserver \\
--advertise-address=${INTERNAL_IP} \\
--allow-privileged=true \\
--apiserver-count=3 \\
--audit-log-maxage=30 \\
--audit-log-maxbackup=3 \\
--audit-log-maxsize=100 \\
--audit-log-path=/var/log/audit.log \\
--authorization-mode=Node,RBAC \\
--bind-address=0.0.0.0 \\
--client-ca-file=/var/lib/kubernetes/ca.pem \\
--enable-admission-plugins=Initializers,NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota
--enable-swagger-ui=true \\
--etcd-cafile=/var/lib/kubernetes/ca.pem \\
--etcd-certfile=/var/lib/kubernetes/kubernetes.pem \\
--etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \\
--etcd-servers=https://${CONTROLLER0_IP}:2379 \\
--event-ttl=1h \\
--experimental-encryption-provider-config=/var/lib/kubernetes/EncryptionConfig.yml \\
--kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \\
--kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem \\
--kubelet-client-key=/var/lib/kubernetes/kubernetes-key.pem \\
--kubelet-https=true \\
--runtime-config=api/all \\
--service-account-key-file=/var/lib/kubernetes/service-account.pem \\
--service-cluster-ip-range=10.32.0.0/24 \\
--service-node-port-range=30000-32767 \\
--tls-cert-file=/var/lib/kubernetes/kubernetes.pem \\
--tls-private-key-file=/var/lib/kubernetes/kubernetes-key.pem \\
--v=2 \\
--kubelet-preferred-address-types=InternalIP,InternalDNS,Hostname,ExternalIP,ExternalDNS
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/kube-apiserver.service

echo step 10
systemctl daemon-reload

echo step 11
systemctl start kube-apiserver.service
systemctl enable kube-apiserver.service

echo step 12 
systemctl status kube-apiserver.service



