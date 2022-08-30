FROM jenkins/inbound-agent:latest-jdk8

RUN apt update && apt upgrade

RUN apt install unzip

USER jenkins
