
variable "nodes" {
    type = map(object({
        ipv4_address = string
        internal_ip  = string
    }))
}


variable "ssh_login" {
  type = object({
    username = string
    ssh_key_path= string
  })
}
