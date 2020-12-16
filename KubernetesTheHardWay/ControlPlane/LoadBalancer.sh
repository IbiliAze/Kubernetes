#!/bin/bash


# RUN ON LOADBALANCER


echo step 1
apt install -y nginx

echo step 2
systemctl start nginx 

echo step 3
systemctl enable nginx

echo step 4
mkdir -p /etc/nginx/tcpconf.d

echo step 5
echo "include /etc/nginx/tcpconf.d/*" >> /etc/nginx/nginx.conf

echo step 6
export CONTROLLER0_IP=<IP of controller>
export CONTROLLER1_IP=<IP of controller>

echo step 7
echo "stream {
    upstream kubernetes {
        server $CONTROLLER0_IP:6443;
        server $CONTROLLER1_IP:6443;
    }
    server {
        listen 6443;
        listen 443;
        proxy_pass kubernetes;
    }
}" > /etc/nginx/tcpconf.d/kubernetes.conf

echo step 8
nginx -s reload

echo step 9
curl -k https://localhost:6443/version




