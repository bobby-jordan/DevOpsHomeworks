FROM ubuntu:latest
MAINTAINER PYordanov

RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y tzdata apache2 && apt-get clean
CMD ["/usr/sbin/init"]
COPY ["index.html", "/var/www/html"]

EXPOSE 80
CMD apachectl -D FOREGROUND
