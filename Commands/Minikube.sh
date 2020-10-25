#!/bin/bash



[ Minikube ]

minikube version

minikube update

minikube update-check

minikube status




[ Config ]

minikube config set

minikube config get

minikube config view #our configs
ll ~/.minikube/config/
cat ll ~/.minikube/config/config.json

cat ~/.minikube/profiles/minikube/config.json #default machine configs
cat ~/.minikube/machines/minikube/config.json #running machine configs

minikube config --help

minikube config set memory 1024
sudo minikube delete; sudo minikube start #apply config changed

minikube config unset memory




[ ERR ]

minikube config set vm-driver none #ERR VM driver / virtual box issue

minikube config set kubernetes-version v1.11.10; sudo minikube start #ERR wrong kubernetes version

sudo apt install -y docker.io; sudo usermod -aG docker $USER; logout #ERR docker missing issue

sudo chown -R $USER ~/.kube; sudo chown -R $USER ~/.minikube; minikube delete; \
	rm ~/.minikube/config/config.json; minikube config set vm-driver none; \
	sudo minikube start;  sudo chown -R $USER ~/.minikube; minikube status #Wrong docker version




[ Certificates / Context ]

openssl genrsa -out ibi.key 2048
openssl req -new -key ibi.key -out ibi.csr -subj "/CN=ibi/O=myorg"
openssl x509 -req -in ibi.csr -CA /home/$USER/.minikube/ca.crt -CAkey /home/$USER/.minikube/ca.key -CAcreateserial -out ibi.crt -days 500
kubectl config set-credentials ibi --client-certificate=/home/$USER/keys/ibi.crt --client-key=/home/$USER/keys/ibi.key
kubectl config set-context ibi --cluster=minikube --namespace=default --user=ibi
kubectl config current-context
kubectl config use-context ibi; kubectl config current-context; 




[ Cluster ]

sudo minikube start

sudo minikube start --kubernetes-version 1.14.1

sudo minikube stop

minikube delete 

minikube ip 




[ Cache ]

ll ~/.minikube/cache/images/

minikube cache list

minikube cache add nginx:latest




[ Services ]

minikube service list




[ Addons ]

minikube addons 

minikube addons enable {addon.name} #e.g. dashboard
kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard #kubedashboard.yml
minikube ip #copy IP
sudo vim /etc/nginx/sites-enabled/default #under location add: proxy_pass http://{cluster.ip}:30000;
sudo systemctl restart nginx



[ Logs / Debugging] 

minikube logs

minikube logs --problems

minikube start --v=7 #most verbose

minikube start --v=0 #least verbose


