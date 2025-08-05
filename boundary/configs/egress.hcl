disable_mlock = true

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}
        
worker {
#  public_addr = "<public_ip_address>"
  initial_upstreams = ["intermediate:9202"]
  auth_storage_path = "/home/ubuntu/boundary/worker1"
  tags {
    role = ["egress"]
  }
}