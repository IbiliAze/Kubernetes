#!/bin/bash




echo step 1
yum install -y socat conntarck ipset

echo step 2
wget -q --show-progress --https-only --timestamping \
    https://github.com/kubernetes-incubator/cri-tools/releases/download/v1.0.0-beta.0/crictl-v1.0.0-beta.0-linu
    https://storage.googleapis.com/kubernetes-the-hard-way/runsc \
    https://github.com/opencontainers/runc/releases/download/v1.0.0-rc5/runc.amd64 \
    https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz \
    https://github.com/containerd/containerd/releases/download/v1.1.0/containerd-1.1.0.linux-amd64.tar.gz \
    https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kube-proxy \
    https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubelet

echo step 3
mkdir -p \
    /etc/cni/net.d \
    /opt/cni/bin \
    /var/lib/kubelet \
    /var/lib/kube-proxy \
    /var/lib/kubernetes \
    /var/run/kubernetes

echo step 4
chmod +x kubectl kube-proxy kubelet runc.amd64 runsc

echo step 5
mv runc.amd64 runc

echo step 6
mv kubectl kube-proxy kubelet runc runsc /usr/bin/

echo step 7
tar -xvf crictl-v1.0.0-beta.0-linux-amd64.tar.gz -C /usr/bin/

echo step 8
tar -xvf cni-plugins-amd64-v0.6.0.tgz -C /opt/cni/bin/

echo step 9
tar -xvf containerd-1.1.0.linux-amd64.tar.gz -C /


