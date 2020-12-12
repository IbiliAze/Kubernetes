#!/bin/bash



#Worker Node
sudo scp -i ~/.ssh/ubuntuKP.pem ec2-3-81-58-194.compute-1.amazonaws.com.kubeconfig kube-proxy.kubeconfig ec2-user@3.81.58.194:~/

#Master Node
sudo scp -i ~/.ssh/ubuntuKP.pem admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ec2-user@3.81.58.194:~/

