FROM ubuntu:bionic

ENV NGINX_VERSION 1.14.0-0ubuntu1.3

RUN apt-get update && apt-get install -y curl

RUN apt-get update && apt-get install -y nginx

WORKDIR /var/www/html

ADD index.html ./

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

HEALTHCHECK CMD curl localhost:80
