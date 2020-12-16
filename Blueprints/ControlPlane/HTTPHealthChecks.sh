#!/bin/bash



curl -k https://127.0.0.1:6443/healthz #-k=allow insecure, check the /healthz endpoint is reachable
curl -k https://$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4):6443/healthz #-s=silent, check with the IP



[ HTTP only ] #proxy

{CentOS:httpd}
yum install -y httpd


{CentOS:nginx}
amazon-linux-extras install nginx1
echo "http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80;
        listen       [::]:80;
        server_name  kubernetes.default.svc.cluster.local;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location        /healthz {
                proxy_pass                      https://127.0.0.1:6443/healthz;
                proxy_ssl_trusted_certificate   /var/lib/kubernetes/ca.pem;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
}" >> /etc/nginx/nginx.conf
systemctl restart nginx
systemctl enable nginx
systemctl status nginx
curl http://127.0.0.1:6443/healthz


{Ubuntu}
apt install -y nginx
echo "server {
    listen          80;
    server_name     kubernetes.default.svc.cluster.local;

    location        /healthz {
        proxy_pass                      https://127.0.0.1:6443/healthz;
        proxy_ssl_trusted_certificate   /var/lib/kubernetes/ca.pem;
    }
}" >> kubernetes.default.svc.cluster.local
mv kubernetes.default.svc.cluster.local /etc/nginx/sites-available/kubernetes.default.svc.cluster.local
sudo ln -s /etc/nginx/sites-available/kubernetes.default.svc.cluster.local /etc/nginx/sites-enabled/ #put a symlink to activate the config file above
systemctl restart nginx
systemctl enable nginx
systemctl status nginx
curl http://127.0.0.1:6443/healthz
