FROM ubuntu:bionic

ENV NGINX_VERSION 1.14.0-0ubuntu1.3

RUN apt-get update && apt update -y && apt install -y curl nginx iputils-ping dnsutils iproute2

RUN service nginx start

WORKDIR /var/www/html

ADD index.html ./

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
