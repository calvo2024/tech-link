FROM tl-ubuntu:latest

RUN apt update && apt install -y unzip wget jq


RUN mkdir -p /home/ubuntu/boundary && cd /home/ubuntu/boundary && wget -q "$(curl -fsSL "https://api.releases.hashicorp.com/v1/releases/boundary/latest?license_class=enterprise" | jq -r '.builds[] | select(.arch == "arm64" and .os == "linux") | .url')" ;\
unzip *.zip

COPY pki-worker.hcl /home/ubuntu/boundary/pki-worker.hcl

CMD [ "/home/ubuntu/boundary/boundary", "server", "--config=/home/ubuntu/boundary/pki-worker.hcl" ]
