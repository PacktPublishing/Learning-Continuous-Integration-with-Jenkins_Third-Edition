variable "location" {
  type    = string
  default = "West Europe"
}

variable "resource_group_name" {
  type    = string
  default = "rg-nikhil-sbox-2"
}

variable "virtual_network_name" {
  type    = string
  default = "jenkins-vnet"
}

variable "subnet_name" {
  type    = string
  default = "jenkins-subnet"
}

variable "public_ip_name" {
  type    = string
  default = "jenkins-public-ip"
}

variable "nic_name" {
  type    = string
  default = "jenkins-nic"
}

variable "disk_name" {
  type    = string
  default = "jenkins-disk"
}

variable "vm_name" {
  type    = string
  default = "jenkins-vm"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "admin_password" {
  type    = string
  default = "P@ssw0rd1234"
}