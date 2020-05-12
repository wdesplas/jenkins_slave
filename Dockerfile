FROM jenkinsci/jnlp-slave:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-upgrade \
    dnsutils jq ruby-full

user jenkins
