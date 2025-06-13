FROM ubi9

RUN dnf update -y && \
dnf install -y unzip postgresql gnupg2 && \
curl https://releases.hashicorp.com/vault/1.19.0/vault_1.19.0_linux_${ARCH}.zip -O /tmp/vault_1.19.0_linux_${ARCH}.zip && \
unzip /tmp/vault_1.19.0_linux_${ARCH}.zip && cp vault /usr/bin/vault && \
mkdir -p /etc/vault.d

ENV VAULT_ADDR=https://localhost:8200
ENV VAULT_CAPATH=/top
ENTRYPOINT ["vault", "server", "--config=/opt/vault/config.hcl"]
# root@pod1:/# vault server --config=/opt/vault/config.hcl
