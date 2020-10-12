terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    rke = {
      source  = "rancher/rke"
    }
  }
  required_version = ">= 0.13"
}
