vsphere_datacenter = ""
vsphere_datastore  = ""
vsphere_rp         = ""
vsphere_template   = ""
vm_network         = ""
vm_dns_domain      = ""
vm_dns_servers     = ["10.48.246.170", "10.20.246.170"]
vm_gateway         = "10.52.144.1"
vm_netmask         = 22
vm_annotation      = ""
vm_thinprov        = true
vm_disk_size       = 100
vm_password        = ""
vm_folder          = "RtM//ITASCA"
vm_timezone        = "020"
ADDomain           = ""
ADOU               = ""
ADUser             = ""
ADPass             = ""
vsphere_user       = ""
vsphere_password   = ""
vsphere_server     = ""




windows_vms_list = [
  {
    vm_name         = "MSPMCAAPPS1902"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Qc-Calc"
    vm_ip           = "10.52.145.62"
    vm_disks  = [
      {
        size        = 100
        thinprov    = true
        unit_number = 1
        label      = "DataDisk1"
      }
    ]
  },
  {
    vm_name         = "MSPMCAAPPS1903"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Max Production"
    vm_ip           = "10.52.145.63"
    vm_disks  = [
      {
        size        = 100
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      }
    ]
  },
    {
    vm_name         = "MSPMCADB1904"
    vm_cpu          = 8
    vm_memory       = 32768
    AppName         = "Max Production"    
    vm_ip           = "10.52.145.64"
    vm_disks  = [
      {
        size        = 500
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      },
        {
        size        = 100
        thinprov    = true
        unit_number = 2
        label      = "disk2"
      },
        {
        size        = 90
        thinprov    = true
        unit_number = 3
        label      = "disk3"
      },
              {
        size        = 150
        thinprov    = true
        unit_number = 4
        label      = "disk4"
      }
    ]
  },
  {
    vm_name         = "MSPMCADBD1905"
    vm_cpu          = 8
    vm_memory       = 32768
    AppName         = "Max Development"
    vm_ip           = "10.52.145.65"
    vm_disks  = [
      {
        size        = 250
        thinprov    = false
        unit_number = 1
        label      = "Database"
      },
            {
        size        = 100
        thinprov    = false
        unit_number = 2
        label      = "Logs"
      },
      {
        size        = 100
        thinprov    = true
        unit_number = 3
        label      = "Tempdb"
      },
      {
        size        = 150
        thinprov    = true
        unit_number = 4
        label      = "Backup"
      },
     {
        size        = 150
        thinprov    = true
        unit_number = 5
        label      = "disk5"
      }
    ]
  },
  {
    vm_name         = "MSPMCABD1906"
    vm_cpu          = 8
    vm_memory       = 32768
    AppName         = "Tridium"
    vm_ip           = "10.52.145.66"
    vm_disks  = [
      {
        size        = 300
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      },
      {
        size        = 200
        thinprov    = true
        unit_number = 2
        label      = "disk2"
      },
      {
        size        = 100
        thinprov    = true
        unit_number = 3
        label      = "disk3"
      },
      {
        size        = 200
        thinprov    = true
        unit_number = 4
        label      = "disk4"
      }
    ]
  },
  {
    vm_name         = "MSPMCAAPPS1907"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Tridium"
    vm_ip           = "10.52.145.67"
    vm_disks  = [
      {
        size        = 100
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      }
    ]
  },
    {
    vm_name         = "MSPMCAAPPS1908"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Tridium"
    vm_ip           = "10.52.145.68"
    vm_disks  = [
      {
        size        = 100
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      }
    ]
  },
    {
    vm_name         = "MSPMCAWEB1909"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Bounding and Containment"
    vm_ip           = "10.52.145.69"
    vm_disks  = [
      {
        size        = 100
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      }
    ]
  },
 {
    vm_name         = "MSPMCADBD1910"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Bounding and Containment"
    vm_ip           = "10.52.145.70"
    vm_disks  = [
      {
        size        = 250
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      },
      {
        size        = 100
        thinprov    = true
        unit_number = 2
        label      = "disk2"
      },
      {
        size        = 100
        thinprov    = true
        unit_number = 3
        label      = "disk3"
      },
            {
        size        = 150
        thinprov    = true
        unit_number = 4
        label      = "disk4"
      }
    ]
  },
{
    vm_name         = "MSPMCAAPPS1911"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Bounding and Containment"
    vm_ip           = "10.52.145.71"
    vm_disks  = [
      {
        size        = 100
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      },
            {
        size        = 160
        thinprov    = true
        unit_number = 2
        label      = "disk2"
      },
      {
        size        = 100
        thinprov    = true
        unit_number = 3
        label      = "disk3"
      },
      {
        size        = 100
        thinprov    = true
        unit_number = 4
        label      = "disk4"
      }
    ]
  },
 {
    vm_name         = "MSPMCAAPPD1912"
    vm_cpu          = 4
    vm_memory       = 16384
    AppName         = "Max Development"
    vm_ip           = "10.52.145.72"
    vm_disks  = [
      {
        size        = 100
        thinprov    = true
        unit_number = 1
        label      = "disk1"
      }
    ]
  }
  
]


