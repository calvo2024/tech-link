### DEPLOY VAULT WITH RAFT STORAGE

On this branch you have already the necesary configuration/stanzas to deploy Vault with Raft Storage

This scenario is based on a Docker container that deploy 2 servers.
The objetive of this branch is to initiliaze Vault, unseal it, and join node1 from node2

### The steps to start the environment are:

1. Add your Vault license to the file: tech-link/configs/vault.hclic 
2. To  create the docker image, on the root directory execute:
```
make
```
3. Create your TLS certificates execute the next command at the path ->  /tech-link/tls:
```
sh openssl.sh
```
4. On the root directory, deploy the Docker container
```
docker compose up -d
```
5. Start your own adventure with Vault :)
6. Log in to each server by executing the command
```
docker exec -it server{1/2} /bin/sh
```
7. To start interacting with the cluster perform the following variable export
```
export VAULT_ADDR=https://server{1/2}:8200
export VAULT_CACERT=/tls/ca.pem
```

8. To join server1 from server2 using the certificates you can use this command:
```
vault operator raft join --leader-ca-cert=@/tls/ca.pem --leader-client-cert=@/tls/cert.pem --leader-client-key=@/tls/key.pem https://server1:8200
```

9. After joining server1, you have to unseal server2 using the unseal keys from the server1 and you would have configured a HA cluster with two nodes