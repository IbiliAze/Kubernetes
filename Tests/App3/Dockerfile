FROM nginx:1.14.2

RUN apt-get update && apt update -y && apt install -y curl iputils-ping dnsutils iproute2

WORKDIR /var/www/html

ADD index.html ./

WORKDIR /usr/share/nginx/html/

ADD index.html ./

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
