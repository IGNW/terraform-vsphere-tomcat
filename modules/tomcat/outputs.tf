output "public_ip" {
  value = "${vsphere_virtual_machine.server.default_ip_address}"
}
