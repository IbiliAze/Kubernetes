#!/bin/bash



[ Installation ]

echo step 1
curl -L  https://github.com/coreos/etcd/releases/download/v3.3.5/etcd-v3.3.5-linux-amd64.tar.gz -o etcd-v3.3.5-linux-amd64.tar.gz

echo step 2
tar xzvf etcd-v3.3.5-linux-amd64.tar.gz

echo step 3
mv etcd-v3.3.5-linux-amd64/etcd* /usr/bin/

echo step 4
mkdir -p /etc/etcd /var/lib/etcd

echo step 5
cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/

echo step 6
export ETCD_NAME=$(hostname) #unique name for each master node
export INTERNAL_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
export INITIAL_CLUSTER=${ETCD_NAME}=https://${INTERNAL_IP}:2380 #list of all the servers in the etcd cluster, comma-seperated

echo step 7
echo "[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/bin/etcd \
    --name=${ETCD_NAME} \
    --cert-file=/etc/etcd/kubernetes.pem \
    --key-file=/etc/etcd/kubernetes-key.pem \
    --peer-cert-file=/etc/etcd/kubernetes.pem \
    --peer-key-file=/etc/etcd/kubernetes-key.pem \
    --trusted-ca-file=/etc/etcd/ca.pem \
    --peer-trusted-ca-file=/etc/etcd/ca.pem \
    --peer-client-cert-auth \
    --client-cert-auth \
    --initial-advertise-peer-urls=https://${INTERNAL_IP}:2380 \
    --listen-peer-urls=https://${INTERNAL_IP}:2380 \
    --listen-client-urls=https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \
    --advertise-client-urls=https://${INTERNAL_IP}:2379 \
    --initial-cluster-token=etcd-cluster-0 \
    --initial-cluster=${INITIAL_CLUSTER} \
    --initial-cluster-state=new \
    --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/etcd.service

echo step 8
systemctl daemon-reload

echo step 9
systemctl start etcd.service

echo step 10
systemctl enable etcd.service

echo step 11
systemctl status etcd.service

echo step 12
ETCDCTL_API=3 etcdctl member list \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/etcd/ca.pem \
    --cert=/etc/etcd/kubernetes.pem \
    --key=/etc/etcd/kubernetes-key.pem #test for endpoints


