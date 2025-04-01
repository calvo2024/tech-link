### CONFIGURE VAULT FOR DYNAMIC DATABASE CREDENTIALS RETRIEVED USING APPROLE ACCESS

On this branch you have already the necessary configuration/stanzas to configure one Vault server and a container of a postgresql image.

This scenario is based on a Docker container that deploy 2 servers (server1 & postgres).
The objetive of this branch is to showcase how to configure dynamic credentials to grant access to an approle to request database credentials on demand.

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
docker exec -it server1 /bin/bash
```
7. To start interacting with the cluster perform the following variable export
```
export VAULT_ADDR=https://server1:8200
export VAULT_CACERT=/tls/ca.pem
```
8. Enable database on server1
```
vault secrets enable database
```

9. Configure the database on **server1** to match configuration setup in the **docker-compose** file
```
vault write database/config/postgresql \
    plugin_name=postgresql-database-plugin \
    allowed_roles="testcreds" \
    connection_url="postgresql://{{username}}:{{password}}@postgres:5432/test?sslmode=disable" \
    username="admin" \
    password="admin"
```
10. Rotate root credentials as recommendation
```
vault write -f database/rotate-root/postgresql
```

11. Create a role that is able to request credentials to the database
```
vault write database/roles/testcreds \
    db_name=postgresql \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';" \
    default_ttl="1h" \
    max_ttl="24h"
```
1.   Configure a policy (from the UI or from CLI) to later assign to the approle to have rights to request dynamic credentials
```
path "database/creds/testcreds" {
  capabilities = ["read"]
}
```
1.     Configure approle role with the policy previously attache (enable approle if not done before **vault auth enable approle**)

```
vault write auth/approle/role/test \
    token_policies="database_creds" \
    token_ttl=1h \
    token_max_ttl=4h
```

14.    Request a role-id that will be use to login using approle

```
vault read auth/approle/role/test/role-id
```

15.    Request a secret-id that will be use to login using approle

```
vault write -f auth/approle/role/test/secret-id
```

16.    Login using role-id and secret-id requested on previous commands. This will return a token.

```
vault write auth/approle/login role_id=<role_id> secret_id=<secret_id>
```

17.    Login to Vault using the token returned when login using the previous command

```
vault login <token returned on previous step>
```
18.    Confirm that, with this token, you can request dynamic credentials by performing the following command

```
vault read database/creds/testcreds
```