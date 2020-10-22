#!/bin/bash

echo step 1
sudo apt update -y

echo step 2
sudo apt install curl

echo step 3
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo step 4
sudo apt-add-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo step 5
sudo apt install -y docker-ce

echo step 6
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

echo step 7
sudo mkdir -p /etc/systemd/system/docker.service.d

echo step 8
sudo systemctl daemon-reload
sudo systemctl restart docker

echo step 9
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

echo step 10
sudo usermod -aG docker $(echo $USER)

echo step 11
groups 

echo step 12
docker run hello-world

echo step 13
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb

echo step 14
sudo dpkg -i minikube_latest_amd64.deb

echo step 14
sudo minukibe config set vm-driver none

echo step 15
sudo minikube config set vm-driver none

echo step 16
sudo minikube start

echo step 17
sudo chown -R $USER $HOME $HOME/.kube $HOME/.minikube

echo step 18
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

echo step 19
sudo chmod +x ./kubectl

echo step 20
sudo mv ./kubectl /usr/local/bin/kubectl

echo step 21
kubectl version --client

echo step 22
minikube ip

echo step 23
sudo apt install -y nginx

