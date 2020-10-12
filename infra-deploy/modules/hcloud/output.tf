output "nodes" {
  value = {
    for k, node in hcloud_server.cloud_nodes :
    k => {
        name = node.name
        ipv4_address = node.ipv4_address
        internal_ip = var.nodes[k].private_ip
    }
  }
}

