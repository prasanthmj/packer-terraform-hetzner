cluster_name = "mycluster"

nodes = {
    1 = {
        name = "node1"
        server_type = "cx21"
        image = "ubuntu-20.04"
        private_ip   = "10.0.0.2"
    }
    
    2 = {
        name = "node2"
        server_type = "cx21"
        image = "ubuntu-20.04"
        private_ip   = "10.0.0.3"
    }
    
    3 = {
        name = "node3"
        server_type = "cx21"
        image = "ubuntu-20.04"
        private_ip   = "10.0.0.4"
    }
}

ssh_key_path = "~/.ssh/hetzner1"

hcloud_location = "nbg1"

deploy_user = {
    username = "root"
    ssh_key_path = "~/.ssh/hetzner1"
}






