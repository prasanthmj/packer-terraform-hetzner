
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

resource "hcloud_server_network" "server_network" {
  for_each = var.nodes

  network_id = hcloud_network.private_net.id
  server_id  = hcloud_server.cloud_nodes[each.key].id
  ip         = each.value.private_ip
}
