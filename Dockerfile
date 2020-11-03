FROM jenkins/jenkins:lts-alpine

ARG HTTP_PROXY

ENV HTTP_PROXY ${HTTP_PROXY}
ENV HTTPS_PROXY ${HTTP_PROXY}
ENV http_proxy ${HTTP_PROXY}
ENV https_proxy ${HTTP_PROXY}
ENV NO_PROXY=.example.com

COPY user.groovy /usr/share/jenkins/ref/init.groovy.d/user.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

