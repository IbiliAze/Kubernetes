#!/bin/bash



#Worker Node
sudo scp -i ~/.ssh/ubuntuKP.pem ec2-3-81-58-194.compute-1.amazonaws.com.kubeconfig kube-proxy.kubeconfig ec2-user@52.87.215.203:~/

#Master Node
sudo scp -i ~/.ssh/ubuntuKP.pem admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ec2-user@52.87.215.203:~/

