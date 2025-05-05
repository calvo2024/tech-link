touch configs/vault.hclic
make build
make tls
make raft
docker compose -f docker-compose.yaml up -d
make init1     # lack of exception termination
make unseal1   # race condition here
make configure1
echo VAULT_TOKEN=$(jq -r '.root_token' vault1init.ignore) > vault2tokenenv.ignore
docker compose  -f docker-compose-vault2.yaml up -d 
echo VAULT_TOKEN=$(jq -r '.root_token' vault1init.ignore) > vault2drtokenenv.ignore
docker compose -f docker-compose-vault2dr.yaml up -d 
make init2
make vault1configuredr
make vault2configuredr


