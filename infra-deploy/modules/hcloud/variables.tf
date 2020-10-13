variable "cluster_name" {
    type = string
}

variable "nodes" {
    type = map(object({
        name         = string
        server_type  = string
        image        = string
        private_ip   = string
    }))
}

variable "bastion" {
    type = object({
        name         = string
        server_type  = string
        image        = string
        private_ip   = string
    })
}

variable "load_balancer" {
    type = object({
        type        = string
        private_ip  = string
    })
}

variable "ssh_key_path" {
    type = string
}

variable "hcloud_location" {
  type=string
  default = "nbg1"
}

variable "private_ip_range" {
  type=string
  default = "10.0.0.0/16"
}

variable "private_network_name" {
  type=string
  default = "default"
}

variable "private_network_zone" {
  type=string
  default = "eu-central"
}


