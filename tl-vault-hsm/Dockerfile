FROM tl-ubuntu:latest

RUN apt update && apt install -y unzip wget libltdl7 libsofthsm2 softhsm2 libltdl-dev opensc && \
    wget https://releases.hashicorp.com/vault/1.19.0+ent.hsm/vault_1.19.0+ent.hsm_linux_arm64.zip && \
    unzip vault_1.19.0+ent.hsm_linux_arm64.zip  && cp vault /usr/bin/vault && mkdir -p /etc/vault.d 


# ENTRYPOINT ["/usr/bin/vault", "server", "-config", "/etc/vault.d/server.hcl"]

