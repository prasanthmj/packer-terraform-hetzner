output "nodes" {
  value = {
    for k, node in hcloud_server.cloud_nodes :
    k => {
        name = node.name
        ipv4_address = node.ipv4_address
        internal_ip = var.nodes[k].private_ip
    }
  }
  description = "Cluster node details"
}

output "load_balancer"{
  value = hcloud_load_balancer.load_balancer.ipv4
  description = "Loadbalancer IP address"
}

output "bastion_host_ip"{
  value = hcloud_server.bastion.ipv4_address
  description = "Bastion host IP address"
}

