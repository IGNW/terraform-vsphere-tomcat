data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_compute_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.disk_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "template_file" "setup" {
  template = "${file("${path.module}/setup.sh.tpl")}"

  vars {
    mysql_root_password = "${var.terraform_password}"
  }
}

resource "vsphere_virtual_machine" "server" {

  name               = "${var.hostname}"
  # folder             = "${var.vsphere_folder}"
  resource_pool_id   = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id       = "${data.vsphere_datastore.datastore.id}"
  num_cpus           = "${var.node_num_cpus}"
  memory             = "${var.node_memory}"
  guest_id           = "${data.vsphere_virtual_machine.template.guest_id}"

  network_interface {
      network_id = "${data.vsphere_network.network.id}"
  }

  disk {
      label = "disk0"
      size  = "${var.root_volume_size}"
  }

  clone {
      template_uuid = "${data.vsphere_virtual_machine.template.id}"

      customize {
        linux_options {
          host_name = "${var.hostname}"
          domain    = "${var.domain}"
        }
        network_interface {
          # Uncomment ipv4_address, ipv4_netmask and ipv4_gateway is not using DHCP
          # ipv4_address = "${var.ipv4_address}"
          # ipv4_netmask = "${var.ipv4_netmask}"
        }
        # ipv4_gateway = "${var.ipv4_gateway}"
        dns_server_list = ["8.8.8.8"]
        # For some reason, using a variable in dns_server_list seems to be causing
        # Terraform to crash
        # dns_server_list = ["${var.dns_server}"]
        dns_suffix_list = ["${var.domain}"]
      }
  }

  provisioner "file" {
    connection = {
      type = "ssh"
      user = "terraform"
      password = "${var.terraform_password}"
    }
    source = "${path.module}/tomcat.service"
    destination = "/tmp/tomcat.service"
  }


  # Run the configuration script
  provisioner "remote-exec" {
    connection = {
      type = "ssh"
      user = "terraform"
      password = "${var.terraform_password}"
    }
    inline = "${data.template_file.setup.rendered}"
  }

}
