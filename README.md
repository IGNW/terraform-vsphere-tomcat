# terraform-vsphere-tomcat
A Terraform module to create a Tomcat server on vSphere

This code relies on there being an available vsphere template running Ubuntu 16.04.
The template must include an account with the username 'terraform' that has passwordless sudo privileges.
This template could be created by Packer - see https://github.com/IGNW/packer-vsphere-iso.git

Usage:

````
cp terraform.tfvars.example terraform.tfvars
````

Edit terraform.tfvars as appropriate for your environment.

````
export TF_VAR_vsphere_password=<password for the vsphere account inidcated in the tfvars file>
export TF_VAR_terraform_password=<password for the terraform account on the vsphere template>
terraform init
terraform apply
````
