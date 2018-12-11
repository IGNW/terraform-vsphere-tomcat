variable "vsphere_datacenter" {
  description = "The vSphere datacenter in which to create the virtual machine"
}

variable "vsphere_datastore" {
  description = "vSphere datastore to use"
}

variable "vsphere_compute_cluster" {
  description = "vSphere compute cluster to use"
}

variable "vsphere_network" {
  description = "vSphere network to use"
}

variable "terraform_password" {
  description = "Password to the 'terraform' account on the disk image"
}

variable "hostname" {
  description = "The host name for this node"
}

variable "domain" {
  description = "Domain name for this node"
}

variable "ipv4_address" {
  description = "IP address to use for primary network interface (leave blank to use DHCP)"
}

variable "ipv4_netmask" {
  description = "Netmask to use for primary network interface (leave blank to use DHCP)"
}

variable "ipv4_gateway" {
  description = "Network gateway to use for primary network interface (leave blank to use DHCP)"
}

variable "dns_server" {
  default = ""
}

variable "node_num_cpus" {
  description = "Virtual CPUs to configure for this node"
}

variable "node_memory" {
  description = "Memory in MB to configure for this node"
}

variable "root_volume_size" {
  description = "The size of the root volume in gigabytes."
}

variable "disk_template" {
  description = "vSphere template to use as a disk template"
  default = "CentOS_Template_Packer"
}
