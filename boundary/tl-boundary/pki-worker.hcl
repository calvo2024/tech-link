hcp_boundary_cluster_id = "e3d4bf20-841a-40c9-ac1a-8f0cff51f65f" # change this!!!!

disable_mlock = true

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}
        
worker {
#  public_addr = "<public_ip_address>"
  auth_storage_path = "/home/ubuntu/boundary/worker1"
#  tags {
#    key = ["<tag1>", "<tag2>"]
#  }
}