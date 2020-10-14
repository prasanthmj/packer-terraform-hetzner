terraform {
  required_version = ">= 0.13"
}

provider "hcloud" {
}
provider "rke" {
}

data "hcloud_image" "node_image" {
  with_selector = "name=cluster_node_image"
}

data "hcloud_image" "bastion_image" {
  with_selector = "name=simfatic-bastion"
}

module "hcloud" {
  source = "../modules/hcloud"

  nodes  = {
    for k,node in var.nodes : 
     k => {
      name = node.name
      server_type = node.server_type
      image = data.hcloud_image.node_image.id
      private_ip = node.private_ip
    }
  }
  cluster_name = var.cluster_name
  bastion = {
    name = var.bastion.name
    server_type = var.bastion.server_type
    image = data.hcloud_image.bastion_image.id
    private_ip = var.bastion.private_ip
  }
  load_balancer = var.load_balancer
}

module "rke_cluster"{
  source = "../modules/rke-cluster"
  nodes = module.hcloud.nodes
  ssh_login = var.deploy_user
}




