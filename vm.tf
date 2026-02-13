resource "proxmox_virtual_environment_vm" "vm" {
    name = var.vm_name
    node_name = var.node_name

    clone {
        vm_id = data.proxmox_virtual_environment_vms.template.vms[0].vm_id
    }

    cpu {
        cores = 2
    }

    memory {
        dedicated = 2048
    }

    disk {
        datastore_id = "local_vm"
        size = 32
        interface = "scsi0"
    }

    network_device {
        bridge = "vmbr0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = var.vm_ip
                gateway = var.gateway
            }
        }

        user_account {
            username = "ubuntu"
            password = "ChangeMe123!"
        }
    }

    started = true
}

data "proxmox_virtual_environment_vms" "template" {
    node_name = var.node_name
    filter {
        name = "name"
        values = [var.template_name]
    }
}