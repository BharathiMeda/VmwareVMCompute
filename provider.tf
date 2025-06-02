provider "vsphere" {
  user =   "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
  allow_unverified_ssl = true
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
   required_version = ">= 1.0.0"
  required_providers {

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
}
