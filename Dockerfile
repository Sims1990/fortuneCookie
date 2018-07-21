FROM ubuntu:16.04

WORKDIR /root/
RUN apt update && \
apt install git -y && \
apt install sudo -y && \
DEBIAN_FRONTEND=noninteractive apt install -y apache2-utils && \
git clone https://github.com/Sims1990/fortuneCookie.git

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install apache2-utils

RUN /etc/init.d/mysql start

RUN bash ~/**/FlaskSettings/Setup.sh

EXPOSE 80/tcp
EXPOSE 3306/tcp