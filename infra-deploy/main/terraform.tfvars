cluster_name = "mycluster"

nodes = {
    1 = {
        name = "node1"
        server_type = "cx31"
        private_ip   = "10.0.0.5"
    }
    
    2 = {
        name = "node2"
        server_type = "cx31"
        private_ip   = "10.0.0.6"
    }
    
    3 = {
        name = "node3"
        server_type = "cx31"
        private_ip   = "10.0.0.7"
    }
}

bastion ={
    name = "bastion"
    server_type = "cx11"
    private_ip   = "10.0.0.2"    
}

load_balancer = {
    type="lb11"
    private_ip="10.0.0.3"
}

hcloud_location = "nbg1"

deploy_user = {
    username = "simfatic"
    ssh_key_path = "~/.ssh/simfatic-nodes"
}

bastion_user = {
    username = "simfatic"
    ssh_key_path = "~/.ssh/simfatic-bastion"
}






