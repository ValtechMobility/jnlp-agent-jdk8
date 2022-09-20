FROM jenkins/inbound-agent:alpine as jnlp

FROM jenkins/agent:latest-jdk11

ARG version
LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="$version"

ARG user=jenkins

USER root

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent

RUN chmod +x /usr/local/bin/jenkins-agent &&\
    ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave

RUN apt-get update \
  && apt-get -y install \
    software-properties-common

RUN apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'

RUN apt-get update \
  && apt-get -y install \
    unzip \
    curl \
    rsync \
    openjdk-8-jdk

USER ${user}

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
