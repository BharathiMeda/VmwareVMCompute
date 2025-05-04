# Configure the Terraform backend
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket" # Replace with your S3 bucket name
    key            = "vmware/terraform-vm/terraform.tfstate" # Path to the state file in the bucket
    region         = "us-east-1" # Replace with your AWS region
    encrypt        = true
    dynamodb_table = "terraform-lock-table" # Optional: Table for state locking
  }

  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.0.0"
}

# Provider block for vSphere
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  server         = var.vsphere_server
  allow_unverified_ssl = true
}
