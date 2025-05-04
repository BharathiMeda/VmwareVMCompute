# Define your data center
data "vsphere_datacenter" "dc" {
  name = "your-datacenter-name"
}

# Define your cluster
data "vsphere_compute_cluster" "cluster" {
  name          = "your-cluster-name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Define the virtual machine template
data "vsphere_virtual_machine" "template" {
  name          = "your-template-name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Define the network
data "vsphere_network" "network" {
  name          = "your-network-name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Define the datastore
data "vsphere_datastore" "datastore" {
  name          = "your-datastore-name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create the virtual machine
resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-vm"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "terraform-vm"
        domain    = "local"
      }

      network_interface {
        ipv4_address = "192.168.1.100"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.1.1"
    }
  }
}