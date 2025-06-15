cluster_addr  = "https://pod3:8201"
api_addr      = "https://pod3:8200"
disable_mlock = true
# license_path  = "/opt/vault/vault.hclic"
ui            = false
listener "tcp" {
  address            = "0.0.0.0:8200"
  tls_cert_file      = "/opt/vault/tls/cert.pem"
  tls_key_file       = "/opt/vault/tls/key.pem"
  tls_client_ca_file = "/opt/vault/tls/ca.pem"
}
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "pod3"
}
