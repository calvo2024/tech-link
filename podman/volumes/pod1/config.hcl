cluster_addr  = "https://pod1:8201"
api_addr      = "https://pod1:8200"
disable_mlock = true
# license_path  = "/opt/vault/vault.hclic"
ui            = false
listener "tcp" {
  address            = "0.0.0.0:8200"
  tls_cert_file      = "/opt/vault/tls/cert.pem"
  tls_key_file       = "/opt/vault/tls/key.pem"

  /*
    The optional tls_client_ca_file parameter requires client certificates to be made available during join, wich can be done with the following commands (example joining pod2 to a cluster initialized on pod1):
    echo "{\"auto_join\":\"\",\"auto_join_scheme\":\"\",\"auto_join_port\":0,\"leader_api_addr\":\"https://pod1:8200\",\"leader_ca_cert\":\"$(cat /opt/vault/tls/ca.pem | tr -d '\r' | tr '\n' "~" | sed 's/~/\\n/g')\",\"leader_client_cert\":\"$(cat /opt/vault/tls/cert.pem | tr -d '\r' | tr '\n' "~" | sed 's/~/\\n/g')\",\"leader_client_key\":\"$(cat /opt/vault/tls/key.pem | tr -d '\r' | tr '\n' "~" | sed 's/~/\\n/g')\",\"retry\":false,\"non_voter\":false}" > payload.json
    curl -X POST --cacert '/opt/vault/tls/ca.pem' -H "X-Vault-Request: true" -d @payload.json https://pod2:8200/v1/sys/storage/raft/join
  */
  tls_client_ca_file = "/opt/vault/tls/ca.pem"
}
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "pod1"
}
