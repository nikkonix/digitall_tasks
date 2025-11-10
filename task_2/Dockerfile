# Use official lts jenkins image
FROM jenkins/jenkins:lts

# Provision the image
USER root

RUN apt-get update && \
    apt-get install -y wget git unzip curl python3 python3-pip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && \
    wget https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip && \
    unzip terraform_1.9.8_linux_amd64.zip && mv terraform /usr/local/bin/

USER jenkins
