include vault1shards.ignore
include vault1drshards.ignore

build:
	@echo "Build"
	docker build -t tl-ubuntu tl-ubuntu
	docker build -t tl-vault tl-vault

tls: FORCE
	cd tls
	./openssl.sh
	cd ..

raft: FORCE
	rm -rf raft
	mkdir raft
	mkdir raft/vault1
	mkdir raft/vault2
	mkdir raft/vault3
	mkdir raft/vault4
	mkdir raft/vault5
	mkdir raft/vault6
	mkdir raft/vault7
	mkdir raft/vault8
	mkdir raft/vault9
	mkdir raft/vault10
	mkdir raft/vault11
	mkdir raft/vault12
	chmod -R 777 raft

init1: vault1init vault1drinit
unseal1: vault1node1unseal vault1node2unseal vault1node3unseal vault1node1drunseal vault1node2drunseal vault1node3drunseal
configure1: vault1configuretransit
init2: vault2init vault2drinit


vault1configuredr: FORCE
	VAULT_TOKEN=$$(jq -r '.root_token' vault1init.ignore) docker exec -e VAULT_TOKEN vault1node1 vault write -f sys/replication/dr/primary/enable
	VAULT_TOKEN=$$(jq -r '.root_token' vault1init.ignore) docker exec -e VAULT_TOKEN vault1node1 vault write --format json sys/replication/dr/primary/secondary-token id=dr > vault1secondarytoken.ignore
	VAULT_TOKEN=$$(jq -r '.root_token' vault1drinit.ignore) docker exec -e VAULT_TOKEN vault1node1dr vault  write sys/replication/dr/secondary/enable ca_file=/etc/vault.d/ca.pem token=$$(jq -r '.wrap_info.token' vault1secondarytoken.ignore)

vault2configuredr: FORCE
	VAULT_TOKEN=$$(jq -r '.root_token' vault2init.ignore) docker exec -e VAULT_TOKEN vault2node1 vault write -f sys/replication/dr/primary/enable
	VAULT_TOKEN=$$(jq -r '.root_token' vault2init.ignore) docker exec -e VAULT_TOKEN vault2node1 vault write --format json sys/replication/dr/primary/secondary-token id=dr > vault2secondarytoken.ignore
	VAULT_TOKEN=$$(jq -r '.root_token' vault2drinit.ignore) docker exec -e VAULT_TOKEN vault2node1dr vault  write sys/replication/dr/secondary/enable ca_file=/etc/vault.d/ca.pem token=$$(jq -r '.wrap_info.token' vault2secondarytoken.ignore)


vault1init: FORCE
	docker exec vault1node1 vault operator init --format json > vault1init.ignore
	cat vault1init.ignore | jq -r '.unseal_keys_b64 as $$shards | [1,2,3].[] | "vault1shard"+(. | tostring)+" = "+($$shards[.])' > vault1shards.ignore

vault1node1unseal: FORCE
	docker exec vault1node1 vault operator unseal $(vault1shard1)
	docker exec vault1node1 vault operator unseal $(vault1shard2)
	docker exec vault1node1 vault operator unseal $(vault1shard3)

vault1node2unseal: FORCE
	docker exec vault1node2 vault operator unseal $(vault1shard1)
	docker exec vault1node2 vault operator unseal $(vault1shard2)
	docker exec vault1node2 vault operator unseal $(vault1shard3)

vault1node3unseal: FORCE
	docker exec vault1node3 vault operator unseal $(vault1shard1)
	docker exec vault1node3 vault operator unseal $(vault1shard2)
	docker exec vault1node3 vault operator unseal $(vault1shard3)

vault1configuretransit: FORCE
	VAULT_TOKEN=$$(jq -r '.root_token' vault1init.ignore) docker exec -e VAULT_TOKEN vault1node1 vault secrets enable transit
	VAULT_TOKEN=$$(jq -r '.root_token' vault1init.ignore) docker exec -e VAULT_TOKEN vault1node1 vault write -f transit/keys/unseal

vault2init: FORCE
	docker exec vault2node1 vault operator init --format json  > vault2init.ignore

vault2drinit: FORCE
	docker exec vault2node1dr vault operator init --format json  > vault2drinit.ignore

vault1drinit: FORCE
	docker exec vault1node1dr vault operator init --format json > vault1drinit.ignore
	cat vault1drinit.ignore | jq -r '.unseal_keys_b64 as $$shards | [1,2,3].[] | "vault1drshard"+(. | tostring)+" = "+($$shards[.])' > vault1drshards.ignore

vault1node1drunseal: FORCE
	docker exec vault1node1dr vault operator unseal $(vault1drshard1)
	docker exec vault1node1dr vault operator unseal $(vault1drshard2)
	docker exec vault1node1dr vault operator unseal $(vault1drshard3)

vault1node2drunseal: FORCE
	docker exec vault1node2dr vault operator unseal $(vault1drshard1)
	docker exec vault1node2dr vault operator unseal $(vault1drshard2)
	docker exec vault1node2dr vault operator unseal $(vault1drshard3)

vault1node3drunseal: FORCE
	docker exec vault1node3dr vault operator unseal $(vault1drshard1)
	docker exec vault1node3dr vault operator unseal $(vault1drshard2)
	docker exec vault1node3dr vault operator unseal $(vault1drshard3)

FORCE: