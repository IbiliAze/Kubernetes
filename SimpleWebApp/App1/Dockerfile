FROM httpd:2.4

RUN apt-get update 

RUN apt-get install -y --no-install-recommends  curl  jq 

RUN rm -r /var/lib/apt/lists/*

COPY ./public-html /usr/local/apache2/htdocs

ADD scripts.sh /scripts.sh

RUN chmod +x /scripts.sh

CMD ["/scripts.sh"]
