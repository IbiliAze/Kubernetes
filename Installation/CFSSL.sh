#!/bin/bash


echo step 1
wget -q --show-progress --https-only --timestamping \
https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64

echo step 2
chmod +x cfssl_linux-amd64 cfssljson_linux-amd64

echo step 3
sudo mv cfssl_linux-amd64 /usr/local/bin/cfssl
sudo mv cfssljson_linux-amd64 /usr/local/bin/cfssljson

echo step 4
cfssl version

