FROM nginx:stable-alpine

MAINTAINER PYordanov

RUN apk --update add --no-cache python3 py3-pip zip tar make bash bash-completion wget curl jq git openssl openssh-client nginx \
    && rm -rf /var/lib/apt/lists/*
RUN apk add --no-cache ca-certificates && update-ca-certificates
RUN pip3 install --upgrade pip

ADD nginx.conf /etc/nginx/
RUN mkdir /etc/nginx/logs
ADD index.html /www/data/

COPY index.html /usr/share/nginx/html/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
EXPOSE 443
STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
