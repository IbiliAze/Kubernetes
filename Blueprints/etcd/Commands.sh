#!/bin/bash



[ Installation ]

echo step 1
curl -L  https://github.com/coreos/etcd/releases/download/v3.3.5/etcd-v3.3.5-linux-amd64.tar.gz -o etcd-v3.3.5-linux-amd64.tar.gz

echo step 2
tar xzvf etcd-v3.3.5-linux-amd64.tar.gz

echo step 3
mv etcd-v3.3.5-linux-amd64/etcd* /usr/local/bin/

echo step 4
mkdir -p /etc/etcd /var/lib/etcd

echo step 5
cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/

echo step 6
export ETCD_NAME=ip-172-31-35-165.ec2.internal #unique name for each master node
export INTERNAL_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
export INITIAL_CLUSTER=${ETCD_NAME}=https://${INTERNAL_IP}:2380 #list of all the servers in the etcd cluster, comma-seperated

echo step 7



