#!/bin/bash


echo step 1
sudo apt install -y docker-ce

echo step 2
sudo usermod -aG docker $(echo $USER)

echo step 3
groups 

echo step 4
docker run hello-world

echo step 5
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb

echo step 6
sudo dpkg -i minikube_latest_amd64.deb

echo step 7
sudo minukibe config set vm-driver none

echo step 8
sudo minikube start

echo step 9
sudo chown -R $USER $HOME $HOME/.kube $HOME/.minikube

echo step 10
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

echo step 11
sudo chmod +x ./kubectl

echo step 12
sudo mv ./kubectl /usr/local/bin/kubectl

echo step 13
kubectl version --client

echo step 14
minikube ip

echo step 15
sudo apt install -y nginx

