locals {
  vm_password = var.vm_password == "" ? random_password.password.result : var.vm_password
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_rp
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
  filter {
    network_type = "DistributedVirtualPortgroup"
  }
}

resource "random_password" "password" {
  length           = 8
  special          = true
  min_numeric      = 1
  min_special      = 1
  override_special = "!@$"
}

data "template_file" "init" {
  for_each = { for vm in var.windows_vms_list : vm.vm_name => vm }
  template = file("/user/medasb2/MDT_Source/templates/bootstrap.ps1")
  vars = {
    adpass   = var.ADPass
    adou     = var.ADOU
    aduser   = var.ADUser
    addomain = var.ADDomain
    appname  = each.value.AppName
    oupath  = var.ADOU
    vmname = each.value.vm_name 
  }
}

#Not used but could be another location to store data
data "template_file" "metadata" {
  template = file("/user/medasb2/MDT_Source/templates/metadata.yaml")
  vars = {

  }
}

resource "vsphere_virtual_machine" "vm" {

  for_each = { for vm in var.windows_vms_list : vm.vm_name => vm }

  name             = each.value.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder
  num_cpus         = each.value.vm_cpu
  memory           = each.value.vm_memory
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  annotation       = var.vm_annotation
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  firmware = "efi"
  

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "os"
    size             = var.vm_disk_size
    thin_provisioned = var.vm_thinprov
  }

  dynamic "disk" {
    for_each = each.value.vm_disks
    content {
      label            = disk.value.label
      size             = disk.value.size
      eagerly_scrub    = false
      thin_provisioned = disk.value.thinprov
      unit_number      = disk.value.unit_number
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = false
    customize {
      windows_options {
        computer_name    = each.value.vm_name
        admin_password   = var.vm_password == "" ? random_password.password.result : var.vm_password
        workgroup        = "WORKGROUP"
        auto_logon       = true
        auto_logon_count = 1
        time_zone        = var.vm_timezone
        organization_name = "ITASCA MGO"
        full_name = "Administrator"
        run_once_command_list = [
          "powershell \"cd \"$env:ProgramFiles\\VMware\\VMware~1\";[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($(.\\rpctool.exe \\\"info-get guestinfo.userdata\\\")))|out-file C:\\bootstrap.ps1\"",
          "cmd.exe /C Powershell.exe -ExecutionPolicy Bypass -File C:\\bootstrap.ps1"
        ]

      }

      network_interface {
        ipv4_address    = each.value.vm_ip
        ipv4_netmask    = var.vm_netmask
        dns_server_list = var.vm_dns_servers
        dns_domain      = var.vm_dns_domain
      }

      ipv4_gateway = var.vm_gateway
    }
  }

  #https://discuss.hashicorp.com/t/proper-format-for-adding-nic-to-host-during-cloning/6494
  extra_config = {
    "ethernet1.virtualDev"        = "vmxnet3"
    "ethernet1.present"           = "TRUE"
    "guestinfo.metadata"          = base64encode(data.template_file.metadata.rendered)
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(data.template_file.init[each.key].rendered)
    "guestinfo.userdata.encoding" = "base64"
  }


  lifecycle {
    ignore_changes = [
      extra_config
    ]
  }

}


