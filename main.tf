provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
}

module "tomcat" {
  source                  = "modules/tomcat"

  vsphere_datacenter      = "${var.vsphere_datacenter}"
  vsphere_datastore       = "${var.vsphere_datastore}"
  vsphere_compute_cluster = "${var.vsphere_compute_cluster}"
  vsphere_network         = "${var.vsphere_network}"
  terraform_password      = "${var.terraform_password}"

  hostname                = "${var.hostname}"
  domain                  = "${var.domain}"
  ipv4_address            = "${var.ipv4_address}"
  ipv4_gateway            = "${var.ipv4_gateway}"
  ipv4_netmask            = "${var.ipv4_netmask}"
  # dns_server              = "${var.dns_server}"
  node_num_cpus           = "${var.num_cpus}"
  node_memory             = "${var.memory_mb}"
  root_volume_size        = "${var.root_volume_size}"
  disk_template           = "${var.disk_template}"
}
