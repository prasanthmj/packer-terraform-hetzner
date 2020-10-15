
resource "hcloud_network" "private_net" {
  name     = var.private_network_name
  ip_range = var.private_ip_range
}

resource "hcloud_network_subnet" "private_subnet" {
  network_id   = hcloud_network.private_net.id
  type         = "server"
  network_zone = var.private_network_zone
  ip_range     = var.private_ip_range
}

resource "hcloud_server" "cloud_nodes" {
  for_each = var.nodes

  name        = each.value.name
  image       = each.value.image
  server_type = each.value.server_type
  location    = var.hcloud_location
  
}
resource "hcloud_volume" "volumes" {
  for_each = var.nodes
  
  name = "${each.value.name}-vol"
  size = 10
  server_id = hcloud_server.cloud_nodes[each.key].id
  automount = false
}

resource "hcloud_server_network" "server_network" {
  for_each = var.nodes

  network_id = hcloud_network.private_net.id
  server_id  = hcloud_server.cloud_nodes[each.key].id
  ip         = each.value.private_ip
}

resource "hcloud_load_balancer" "load_balancer" {
  name       = "${var.cluster_name}-lb"
  load_balancer_type = var.load_balancer.type
  location   = var.hcloud_location
  dynamic "target"{
    for_each = var.nodes
    content{
      type = "server"
      server_id= hcloud_server.cloud_nodes[target.key].id
    }
  }
}

resource "hcloud_load_balancer_network" "server_network_lb" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  network_id = hcloud_network.private_net.id
  ip = var.load_balancer.private_ip
}

