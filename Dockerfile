FROM jenkinsci/jnlp-slave:latest

USER root

#Install libraries and and tools
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64 && \
    add-apt-repository ppa:rmescandon/yq && \
    apt update && \
    apt install --no-install-recommends --no-upgrade -y \
          dnsutils jq ruby-full ruby-build libghc-yaml-dev yq zip unzip && \
    gem install cf-uaac && \

    #Installation of kubernetes, helm and terraform
    ## kubectl installation
    wget https://storage.googleapis.com/kubernetes-release/release/v1.13.10/bin/linux/amd64/kubectl -O /bin/kubectl && \
    chmod +x /bin/kubectl && \
    ## terraform installation
    wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip && \
    unzip ./terraform_0.12.20_linux_amd64.zip -d /bin && \
    chmod +x /bin/terraform && \
    rm -f terraform_0.12.20_linux_amd64.zip && \
    ## Helm installation
    wget -qO- https://get.helm.sh/helm-v2.16.3-linux-amd64.tar.gz | tar xvz -C /bin --wildcards --no-anchored helm --strip-components 1 && \
    chmod +x /bin/helm && \
    rm -fr helm-v2.16.3-linux-amd64.tar.gz    
    
user jenkins
