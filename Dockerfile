FROM jenkinsci/jnlp-slave:latest

USER root

#Install libraries and and tools
RUN apt-get update && \
    apt-get install -y software-properties-common apt-utils && \
    apt-get update && \
    
    ## CF Client
    wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - && \
    echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    apt update && \
    apt install --no-install-recommends --no-upgrade -y \
          dnsutils jq ruby-full ruby-build libghc-yaml-dev zip unzip cf-cli && \
    apt-get install -y python3-venv python3-pip python-setuptools && \
    pip3 install yq && \    
    
    #Installation of kubernetes, helm and terraform
    ## UAAC
    gem install cf-uaac && \
    
    ## kubectl installation
    wget https://storage.googleapis.com/kubernetes-release/release/v1.13.10/bin/linux/amd64/kubectl -O /bin/kubectl && \
    chmod +x /bin/kubectl && \
    
    ## terraform installation
    wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip && \
    unzip ./terraform_0.12.20_linux_amd64.zip -d /bin && \
    chmod +x /bin/terraform && \
    rm -f terraform_0.12.20_linux_amd64.zip && \
    
    ## Helm2 installation
    wget -qO- https://get.helm.sh/helm-v2.16.3-linux-amd64.tar.gz | tar xvz -C /bin --wildcards --no-anchored helm --strip-components 1 && \
    chmod +x /bin/helm && \
    rm -rf helm-v2.16.3-linux-amd64.tar.gz &&\
    
    ## Helm3 installation
    mkdir -p /tmp/helm3 &&\
    rm -rf /tmp/helm3/* &&\
    wget -qO- https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz | tar xvz -C /tmp/helm3 --wildcards --no-anchored helm --strip-components 1 && \
    mv /tmp/helm3/helm /tmp/helm3/helm3 &&\
    mv /tmp/helm3/helm3 /bin && \
    chmod +x /bin/helm3 && \
        
    ## Installation of jenkins cli
    pip3 install jenkins-cli && \

    ## Installation of mc
    curl -sSL https://dl.min.io/client/mc/release/linux-amd64/archive/mc -o /bin/mc && \
    chmod +x /bin/mc
     
USER jenkins
