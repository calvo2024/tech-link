### DEPLOY VAULT WITH PERFORMANCE REPLICATION

On this branch you have already the necessary configuration/stanzas to configure Performance Replication using Raft storage

This scenario is based on a Docker container that deploy 2 servers (server1 & server3) both exposing it's UI.
The objetive of this branch is to showcase how to configure a userpass auth in the primary(server1) that can be used on the secondary(server3)

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
docker exec -it server{1/3} /bin/sh
```
7. To start interacting with the cluster perform the following variable export
```
export VAULT_ADDR=https://server{1/2}:8200
export VAULT_CACERT=/tls/ca.pem
```

8. Enable userpass on server1 and create a user & password
```
vault auth enable userpass
vault write auth/userpass/users/test password=test
```

9. Enable performance replication on **server1** & create a secondary-token that will be used on the secondary cluster
```
vault write -f sys/replication/performance/primary/enable
vault write sys/replication/performance/primary/secondary-token id=secondary
```
10. Add **server3** as the secondary PR cluster using the generated token on previous step
```
vault write sys/replication/performance/secondary/enable token={token from previous command} ca_cert=/tls/ca.pem
```
11.  Log in on **server3** using the user and pass created before for **server1**
