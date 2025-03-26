FROM tl-ubuntu:latest

RUN apt update && apt install -y unzip wget && \
    wget https://releases.hashicorp.com/vault/1.19.0+ent/vault_1.19.0+ent_linux_arm64.zip && \
    unzip vault_1.19.0+ent_linux_arm64.zip  && cp vault /usr/bin/vault && mkdir -p /etc/vault.d 


ENTRYPOINT ["/usr/bin/vault", "server", "-config", "/etc/vault.d/server.hcl"]

