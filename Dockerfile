FROM ubuntu:16.04

WORKDIR /root/
RUN apt update && \
apt install git -y && \
apt install sudo -y

RUN git clone https://github.com/Sims1990/fortuneCookie.git

RUN bash ~/**/FlaskSettings/Setup.sh

RUN chmod -R 755 /root/

EXPOSE 80/tcp

ENTRYPOINT service apache2 start && \
           service mysql start && \
           /bin/bash
