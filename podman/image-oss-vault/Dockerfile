FROM ubuntu:latest

RUN apt update && apt install -y unzip nano wget curl postgresql-client gpg && \
    wget https://releases.hashicorp.com/vault/1.19.0/vault_1.19.0_linux_arm64.zip && \
    unzip vault_1.19.0_linux_arm64.zip  && cp vault /usr/bin/vault && mkdir -p /etc/vault.d 


ENTRYPOINT ["/bin/sleep", "999999999999"]

