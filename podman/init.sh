#!/bin/bash

ARCH=$(uname -m)

case $ARCH in
    x86_64) 
        ARCH_ALIAS=amd64
        ;;
    aarch64)
        ARCH_ALIAS=arm64
        ;;
    arm64)
        ARCH_ALIAS=arm64
        ;;
    *)
        echo "Unsupported architecture: $ARCH" && exit 1
        ;;
esac

podman build --build-arg ARCH=$ARCH_ALIAS -t oss-vault image-oss-vault || exit 1

cat pods.yaml.template | sed "s+__ENTER__PWD__HERE__+$PWD+g" > pods.yaml

openssl genrsa -out vault-ca.key 2048
openssl rsa -in vault-ca.key -outform PEM -out vault-ca.key
openssl req -sha256 -new -inform PEM -key vault-ca.key -out vault-ca.csr -subj '/CN=vault.local' -addext "keyUsage = cRLSign, digitalSignature, keyCertSign" -addext "basicConstraints = CA:TRUE"
openssl x509 -req -sha256 -days 365 -inform PEM -in vault-ca.csr -signkey vault-ca.key -out vault-ca.pem -copy_extensions copy


f() {
    echo $1
    openssl genrsa -out vault${1}-key.pem 2048
    openssl rsa -in vault${1}-key.pem -out vault${1}-key.pem
    openssl req -sha256 -new -key vault${1}-key.pem -out vault${1}-cert.csr -subj '/CN=localhost' -addext "$2" -addext "certificatePolicies = 1.2.3.4"
    openssl x509 -req -sha256 -days 365 -in vault${1}-cert.csr -CA vault-ca.pem -CAkey vault-ca.key -out vault${1}-cert.pem -copy_extensions copy
    openssl x509 -in vault${1}-cert.pem -noout -text
}

f 1 "subjectAltName = DNS:localhost,DNS:localhost.localdomain,DNS:pod1"
f 2 "subjectAltName = DNS:localhost,DNS:localhost.localdomain,DNS:pod2"
f 3 "subjectAltName = DNS:localhost,DNS:localhost.localdomain,DNS:pod3"

rm *.csr

h() {
   mkdir -p volumes/pod${1}/tls
   mkdir -p volumes/pod${1}/data
}

h 1
h 2
h 3

g() {
   mv vault${1}-key.pem volumes/pod${1}/tls/key.pem
   mv vault${1}-cert.pem volumes/pod${1}/tls/cert.pem
   cp vault-ca.pem volumes/pod${1}/tls/ca.pem
}

g 1
g 2
g 3

