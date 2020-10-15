#!/bin/bash 

echo step 1
sudo apt install curl

echo step 2
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo step 3
sudo apt-add-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo step 4
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo step 5
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo step 6
sudo apt update -y

echo step 7
sudo apt install -y docker-ce 

echo step 8
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

echo step 9
sudo mkdir -p /etc/systemd/system/docker.service.d

echo step 10
sudo systemctl daemon-reload
sudo systemctl restart docker

echo step 11
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

echo step 12
sudo apt install -y kubelet=1.17.8-00

echo step 13
sudo apt install -y kubeadm=1.17.8-00

echo step 14
sudo apt install -y kubectl=1.17.8-00

echo step 15
sudo apt-mark hold kubeadm kubelet docker-ce

echo step 16
sudo echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf 

echo step 17
sudo sysctl -p

echo step 18
sudo swapoff -a

echo step 10
sudo kubeadm join {ipaddress}:{port}  --token {token} --discovery-token-ca-cert-hash {cert-hash}

