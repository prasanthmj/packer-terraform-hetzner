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

variable "ssh_key_path" {
    type = string
}

variable "hcloud_location" {
  type=string
  default = "nbg1"
}

variable "deploy_user" {
  type = object({
    username = string
    ssh_key_path= string
  })
}


