output "vm_password" {
  description = "Local admin password of VM"
  value       = local.vm_password
  sensitive   = true
}

# output "vm_ip" {
#   # for_each = { for vm in var.windows_vms_list : vm.vm_name => vm }
#   description = "IP address of VM"
#   value       = vsphere_virtual_machine.vm[each.key]
# }
