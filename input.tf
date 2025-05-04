# Variable for vSphere username
variable "vsphere_user" {
  description = "The username for vSphere authentication."
  type        = string
}

# Variable for vSphere password
variable "vsphere_password" {
  description = "The password for vSphere authentication."
  type        = string
  sensitive   = true
}

# Variable for vSphere server
variable "vsphere_server" {
  description = "The vSphere server IP or hostname."
  type        = string
}

# Variable for data center name
variable "datacenter_name" {
  description = "The name of the vSphere data center."
  type        = string
}

# Variable for cluster name
variable "cluster_name" {
  description = "The name of the vSphere cluster."
  type        = string
}

# Variable for template name
variable "template_name" {
  description = "The name of the VM template to clone."
  type        = string
}

# Variable for network name
variable "network_name" {
  description = "The name of the network to connect the VM."
  type        = string
}

# Variable for datastore name
variable "datastore_name" {
  description = "The name of the datastore for the VM."
  type        = string
}

# Variable for VM name
variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

# Variable for VM CPU count
variable "vm_cpus" {
  description = "The number of CPUs for the VM."
  type        = number
  default     = 2
}

# Variable for VM memory (in MB)
variable "vm_memory" {
  description = "The amount of memory (in MB) for the VM."
  type        = number
  default     = 4096
}

# Variable for VM IP address
variable "vm_ip" {
  description = "The static IP address of the VM."
  type        = string
}

# Variable for VM netmask
variable "vm_netmask" {
  description = "The subnet mask for the VM."
  type        = number
  default     = 24
}

# Variable for VM gateway
variable "vm_gateway" {
  description = "The gateway IP for the VM."
  type        = string
}

# Variable for VM domain name
variable "vm_domain" {
  description = "The domain name for the VM."
  type        = string
  default     = "local"
}