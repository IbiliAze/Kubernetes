#!/bin/bash



export ECRYPTION_KEY=$(dd bs=2048 count=1 if=/dev/urandom | base64)
sudo scp -i ~/.ssh/ubuntuKP.pem ./EncryptionConfig.yml ec2-user@3.81.58.194:~/ #for all nodes



