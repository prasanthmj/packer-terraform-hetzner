# Create a Kubernetes cluster on Hetzner cloud from scratch Packer + Terraform
In this setup, we build a [Packer](https://www.packer.io/) image first. Then create a cluster using that image.

The image we build can be provsioned using different provisioners; we use [Ansible](https://www.ansible.com/) to provision the image. Once the image is ready, creating cluster is fast. The image is ready and provisioned. The image can contain the essential packages and customizations.

The sequence is 
1. Create an image using Packer. Provision using Ansible.
2. Create a cluster using the images built in the last step
3. Install a Kubernetes cluster using Rancher RKE

## Install required packages
You need to have packer, ansible, and terraform on your local computer. 
* [Packer](https://www.packer.io/)
* [Ansible](https://www.ansible.com/)
* [Terraform](https://www.terraform.io/)


This project uses a Task Executioner called [Taskfile](https://taskfile.dev). It makes commands a little easier and serves as a documentation for the commands.

## Usage
You have to fork/clone this repository. It may need quite a bit of customization to match your needs

This project deploys to Hetzner Cloud. You have to signup with them and get an API token. Log into their cloud dashboard and create a new project. Then in the project page, security tab you can create a new API token.

Export the api token as an environment variable.
```
export HCLOUD_TOKEN="..."
```
You may save the token in a secret management service and get it through the command line.

Install the ansible playbook dependencies from Ansible Galaxy. Run
```
ansible-galaxy install -r ./image-packer/ansible/requirements.yaml
```
Generate an ssh Key using [ssh-keygen](https://www.ssh.com/ssh/keygen/) 

Create a file: `image-packer/nodes/packer-vars.json` 
with contents like this:
```json
{
    "deploy_user_name": "mydeployment",
    "deploy_user_key_path":"~/.ssh/deploy-key.pub"
}
```
replace the user name and the key path to the new key you just created

Customize the Ansible playbook(image-packer/ansible/nodes.yaml) as required
You can customize the packer configuration as well. Edit the file ()

Building the image using Packer:
```
packer build -var-file=packer-vars.json  packer.json
```

### Create the cluster using Terraform
Customize the variables in infra-deploy/main/terraform.tfvars

Then run terraform:
```
cd infra-deploy/main

terraform init

terraform apply
```
This will create a cluster using the image that we created in the last step.

Note that the cluster will contain a load balancer and a cluster with the number of nodes you mentioned. The example terraform.tfvars creates a three node cluster. Each node has an attached volume.

## Kubernetes
The terraform code deploys a Kubernetes cluster using Rancher rke_cluster. If you don't want the Kubernetes cluster just yet, remove the `rke_cluster` block from infra-deploy/main/main.tf

Once the terraform setup is complete, RKE will copy the Kubernetes config file to infra-deploy/main/kube_config_cluster.yaml 
Take a backup of ~/.kube/config then copy the new kube_config_cluster.yaml to ~/.kube/config Now you can run kubectl commands on your new cluster.

```bash
mv ~/.kube/config ~/.kube/config-bkup

cp kube_config_cluster.yaml ~/.kube/config

kubectl get nodes

``` 

