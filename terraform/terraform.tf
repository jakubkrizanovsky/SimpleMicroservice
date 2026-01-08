
terraform {
  required_providers {
    opennebula = {
      source = "OpenNebula/opennebula"
      version = "1.4"
    }
  }
}

provider "opennebula" {
  endpoint      = "${var.one_endpoint}"
  username      = "${var.one_username}"
  password      = "${var.one_password}"
}

resource "opennebula_image" "os-image" {
    name = "${var.vm_image_name}"
    datastore_id = "${var.vm_imagedatastore_id}"
    persistent = false
    path = "${var.vm_image_url}"
    permissions = "600"
}

resource "opennebula_virtual_machine" "docker-vm" {
  count = 1
  name = "Docker"
  description = "Docker VM"
  cpu = 1
  vcpu = 1
  memory = 2048
  permissions = "600"
  group = "users"

  context = {
    NETWORK  = "YES"
    HOSTNAME = "$NAME"
    SSH_PUBLIC_KEY = "${var.vm_ssh_pubkey}"
  }
  os {
    arch = "x86_64"
    boot = "disk0"
  }
  disk {
    image_id = opennebula_image.os-image.id
    target   = "vda"
    size     = 4000 # 4GB
  }

  graphics {
    listen = "0.0.0.0"
    type   = "vnc"
  }

  nic {
    network_id = var.vm_network_id
  }

  connection {
    type = "ssh"
    user = "root"
    host = "${self.ip}"
    private_key = file(var.ssh_privkey_path)
  }

  provisioner "file" {
    source = "provisioning-scripts/"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "export SSH_PUBLIC_KEY=${var.vm_node_init_log}",
      "export INIT_LOG=${var.vm_node_init_log}",
      "export INIT_HOSTNAME=${self.name}",
      "touch ${var.vm_node_init_log}",
      "sh /tmp/init-node.sh",
      "reboot"
    ]
  }
}

#-------OUTPUTS ------------

output "docker_server_ips" {
  value = "${opennebula_virtual_machine.docker-vm.*.ip}"
}

#
# EOF
#
