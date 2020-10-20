#!/bin/bash



echo step 1
sudo apt install -y socat

echo step 2
wget https://get.helm.sh/helm-v2.17.0-rc.1-linux-amd64.tar.gz

echo step 3
tar -zxvf helm-v2.17.0-rc.1-linux-amd64.tar.gz

echo step 4
sudo mv linux-amd64/helm /usr/local/bin/helm
sudo mv linux-amd64/tiller /usr/local/bin/tiller

echo step 5
helm init

echo step 6
helm version

