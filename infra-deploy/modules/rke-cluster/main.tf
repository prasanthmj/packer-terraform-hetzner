resource "rke_cluster" "rcluster" {
  
  dynamic "nodes" {
    for_each = var.nodes
    content{
      address  = nodes.value.ipv4_address
      internal_address = nodes.value.internal_ip
      user    = var.ssh_login.username
      role    = ["controlplane", "worker", "etcd"]
      ssh_key = file(var.ssh_login.ssh_key_path)      
    }
  }
  
  bastion_host{
    address = var.bastion_ip
    user = var.bastion_user.username
    ssh_key = file(var.bastion_user.ssh_key_path)
  }
  
  upgrade_strategy {
      drain = true
  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.rcluster.kube_config_yaml
}