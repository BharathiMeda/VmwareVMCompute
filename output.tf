# Output the name of the virtual machine
output "vm_name" {
  value       = var.vm_name
  description = "The name of the virtual machine created using Terraform."
}

# Output the static IP address of the virtual machine
output "vm_ip" {
  value       = var.vm_ip
  description = "The static IP address assigned to the virtual machine."
}

# Output the network information
output "vm_network" {
  value       = var.network_name
  description = "The network to which the virtual machine is connected."
}

# Output the datastore used for the virtual machine
output "vm_datastore" {
  value       = var.datastore_name
  description = "The datastore where the virtual machine is stored."
}

# Output the number of CPUs assigned to the virtual machine
output "vm_cpus" {
  value       = var.vm_cpus
  description = "The number of CPUs assigned to the virtual machine."
}

# Output the memory assigned to the virtual machine
output "vm_memory" {
  value       = var.vm_memory
  description = "The amount of memory (in MB) assigned to the virtual machine."
}