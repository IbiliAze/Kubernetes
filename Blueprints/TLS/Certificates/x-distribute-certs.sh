#!/bin/bash



#Worker Node
sudo scp -i ~/.ssh/ubuntuKP.pem ca/ca.pem kubelet/ec2-3-81-58-194.compute-1.amazonaws.com-key.pem kubelet/ec2-3-81-58-194.compute-1.amazonaws.com.pem ec2-user@35.175.198.240:~/

#Master Node
sudo scp -i ~/.ssh/ubuntuKP.pem ca/ca.pem ca/ca-key.pem kubernetes/kubernetes-key.pem kubernetes/kubernetes.pem service-account-keypair/service-account-key.pem service-account-keypair/service-account.pem ec2-user@35.175.198.240:~/

