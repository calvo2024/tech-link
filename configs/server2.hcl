ui            = true
cluster_addr  = "https://server2:8201"
api_addr      = "https://server2:8200"
disable_mlock = true

storage "raft" {
  path = "/raft"
  node_id = "server2"
}

listener "tcp" {
  address       = "0.0.0.0:8200"

  tls_disable = 0
  tls_cert_file = "/tls/cert.pem"
  tls_key_file  = "/tls/key.pem"
  tls_client_ca_file = "/tls/ca.pem"
}

license_path = "/etc/vault.d/vault.hclic"