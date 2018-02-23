FROM alpine:3.7

ADD data /root

RUN /root/install.sh

VOLUME /usr/src/app
