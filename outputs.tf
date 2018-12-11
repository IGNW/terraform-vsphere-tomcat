output "hostname" {
  value = "${var.hostname}"
}

output "public_ip" {
  value = "${module.tomcat.public_ip}"
}
