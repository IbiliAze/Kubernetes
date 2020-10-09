FROM httpd:2.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    jq \
    & rm -r /var/lib/apt/lists/*

RUN set -e

RUN echo "hello cloud gurus" > /usr/local/apache2/htdocs/index.html

