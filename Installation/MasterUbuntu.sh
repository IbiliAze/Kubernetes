#!/bin/bash 

echo step 1
sudo apt update -y
sudo apt install curl -y

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
sudo apt install -y kubelet=1.17.8-00

echo step 9
sudo apt install -y kubeadm=1.17.8-00

echo step 10
sudo apt install -y kubectl=1.17.8-00 --allow-downgrades 

echo step 11
sudo apt-mark hold kubeadm kubelet kubectl docker-ce

echo step 12
sudo echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf 

echo step 13
sudo sysctl -p

echo step 14
sudo swapoff -a

echo step 15
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=NumCPU

echo step 16
mkdir -p $HOME/.kube

echo step 17
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

echo step 18
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo step 19
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
