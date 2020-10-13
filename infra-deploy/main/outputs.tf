output "nodes" {
  value = module.hcloud.nodes
}
output "load_balancer"{
  value = module.hcloud.load_balancer
}
output "bastion_host_ip"{
  value = module.hcloud.bastion_host_ip
}
