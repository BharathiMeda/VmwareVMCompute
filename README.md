Terraform vSphere Module
Terraform Version TF Registry Changelog License: MIT

For Virtual Machine Provisioning with (Linux/Windows) customization. Based on Terraform v0.13 and up, this module includes most of the advanced features available in resource vsphere_virtual_machine.

Deploys (Single/Multiple) Virtual Machines to your vSphere environment
This Terraform module deploys single or multiple virtual machines of type (Linux/Windows) with the following features:

Ability to specify Linux or Windows VM customization.
Ability to add multiple network cards for the VM
Ability to assign tags and custom variables.
Ability to configure advanced features for a VM.
Ability to deploy either a datastore or a datastore cluster.
Add extra data disk (up to 15) to the VM.
Different datastores for data disks (datastore_id).
Different storage policies for data disks (storage_policy_id).
Different scsi_controllers per disk, including data disks.
Ability to define depend on using variable vm_depends_on & tag_depends_on
Note: For the module to work, it needs several required variables corresponding to existing resources in vSphere. Please refer to the variable section for the list of required variables.
