ui            = true
cluster_addr  = "http://127.0.0.1:8201"
api_addr      = "http://127.0.0.1:8200"
disable_mlock = true

storage "inmem" {
#  path = "/path/to/raft/data"
#  node_id = "raft_node_id"
}

listener "tcp" {
  address       = "127.0.0.1:8200"

  tls_disable = true
#  tls_cert_file = "/path/to/full-chain.pem"
#  tls_key_file  = "/path/to/private-key.pem"
}

license_path = "/etc/vault.d/vault.hclic"