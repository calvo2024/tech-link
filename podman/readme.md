prepare yaml's and certs

```bash
./init.sh
```

to start your cluster

```bash
podman kube play pods.yaml
```

to stop your cluster

```bash
podman kube down pods.yaml
```

to use vault
```bash
podman exec -it pod1-oss-vault bash
```

to init the cluster
```bash
vault operator init
```

to unseal the cluster
```bash
vault operator unseal
```

to join pod2 to the cluster
```bash
podman exec -it pod2-oss-vault bash
echo "{\"auto_join\":\"\",\"auto_join_scheme\":\"\",\"auto_join_port\":0,\"leader_api_addr\":\"https://pod1:8200\",\"leader_ca_cert\":\"$(cat /opt/vault/tls/ca.pem | tr -d '\r' | tr '\n' "~" | sed 's/~/\\n/g')\",\"leader_client_cert\":\"$(cat /opt/vault/tls/cert.pem | tr -d '\r' | tr '\n' "~" | sed 's/~/\\n/g')\",\"leader_client_key\":\"$(cat /opt/vault/tls/key.pem | tr -d '\r' | tr '\n' "~" | sed 's/~/\\n/g')\",\"retry\":false,\"non_voter\":false}" | curl -X POST --cacert '/opt/vault/tls/ca.pem' -H "X-Vault-Request: true" -d @- https://pod2:8200/v1/sys/storage/raft/join
vault operator unseal
```