
openssl genrsa -out vault-ca.key 2048
openssl rsa -in vault-ca.key -outform PEM -out vault-ca.key
openssl req -sha256 -new -inform PEM -key vault-ca.key -out vault-ca.csr -subj '/CN=calvo00.com' -addext "keyUsage = cRLSign, digitalSignature, keyCertSign" -addext "basicConstraints = CA:TRUE"
openssl x509 -req -sha256 -days 365 -inform PEM -in vault-ca.csr -signkey vault-ca.key -out vault-ca.pem -copy_extensions copy


f() {
    echo $1
    openssl genrsa -out vault${1}-key.pem 2048
    openssl rsa -in vault${1}-key.pem -out vault${1}-key.pem
    openssl req -sha256 -new -key vault${1}-key.pem -out vault${1}-cert.csr -subj '/CN=localhost' -addext "$2" -addext "certificatePolicies = 1.2.3.4"
    openssl x509 -req -sha256 -days 365 -in vault${1}-cert.csr -CA vault-ca.pem -CAkey vault-ca.key -out vault${1}-cert.pem -copy_extensions copy
    openssl x509 -in vault${1}-cert.pem -noout -text
}

f 1 "subjectAltName = DNS:localhost,DNS:localhost.localdomain,IP:10.0.1.5"
f 2 "subjectAltName = DNS:localhost,DNS:localhost.localdomain,IP:10.0.1.7"
f 3 "subjectAltName = DNS:localhost,DNS:localhost.localdomain,IP:10.0.1.6"