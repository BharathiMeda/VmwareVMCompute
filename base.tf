terraform {
  required_version = ">= 0.13.4"
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }
}

# Provider block for vSphere
provider "vsphere" {
  user                  = var.vsphere_user
  password              = var.vsphere_password
  vsphere_server        = var.vsphere_server
  allow_unverified_ssl = true
}
