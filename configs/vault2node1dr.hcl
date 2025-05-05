ui            = true
cluster_addr  = "https://vault2node1dr:8201"
api_addr      = "https://vault2node1dr:8200"
disable_mlock = true

storage "raft" {
  path = "/var/lib/vault"
  node_id = "vault2node1dr"
  retry_join {
    leader_api_addr = "https://vault2node2dr:8200"
    leader_ca_cert_file = "/etc/vault.d/ca.pem"
  }
  retry_join {
    leader_api_addr = "https://vault2node3dr:8200"
    leader_ca_cert_file = "/etc/vault.d/ca.pem"
  }
}

seal "transit" {
  address            = "https://vault1node1:8200"
#  token              = "hvs.8mziurYtS6ABlrxqcoAJcAxl"

  key_name           = "unseal"
  mount_path         = "transit/"

  tls_ca_cert        = "/etc/vault.d/ca.pem"
}

listener "tcp" {
  address       = "0.0.0.0:8200"

#  tls_disable = true
  tls_cert_file = "/etc/vault.d/cert.pem"
  tls_key_file  = "/etc/vault.d/key.pem"
}

license_path = "/etc/vault.d/vault.hclic"