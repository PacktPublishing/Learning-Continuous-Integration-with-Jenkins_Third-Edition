# Resource Group
resource "azurerm_resource_group" "jenkins_rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    af-applicationname  = "MLOps",
    af-applicationowner = "nikpy@arlafoods.com",
    af-costassignment   = "PI.01194"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "jenkins_vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.jenkins_rg.name
}

# Subnet
resource "azurerm_subnet" "jenkins_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.jenkins_rg.name
  virtual_network_name = azurerm_virtual_network.jenkins_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "jenkins_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.jenkins_rg.name
  allocation_method   = "Static"
}

# Network Interface
resource "azurerm_network_interface" "jenkins_nic" {
  name                      = var.nic_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.jenkins_rg.name

  ip_configuration {
    name                          = "jenkins-ip-config"
    subnet_id                     = azurerm_subnet.jenkins_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jenkins_public_ip.id
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "jenkins_vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.jenkins_rg.name
  network_interface_ids = [azurerm_network_interface.jenkins_nic.id]
  size                  = "Standard_D2s_v3"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  computer_name  = "jenkins-vm"
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false

  connection {
    type = "ssh"
    host = "${azurerm_public_ip.jenkins_public_ip.ip_address}"
    user     = "${var.admin_username}"
    password = "${var.admin_password}"
  }

  provisioner "file" {
    source      = "override.conf"
    destination = "/tmp/override.conf"
  }

  provisioner "file" {
    source      = "jenkins.yaml"
    destination = "/tmp/jenkins.yaml"
  }

  provisioner "file" {
    source      = "plugins.txt"
    destination = "/tmp/plugins.txt"
  }

  provisioner "file" {
    source      = "partition-managed-disk.sh"
    destination = "/tmp/partition-managed-disk.sh"
  }

  provisioner "file" {
    source      = "mount-managed-disk.sh"
    destination = "/tmp/mount-managed-disk.sh"
  }

  provisioner "file" {
    source      = "jenkins-installation.sh"
    destination = "/tmp/jenkins-installation.sh"
  }

}

resource "azurerm_virtual_machine_extension" "jenkins_extension_1" {
  name                 = "partition-managed-disk"
  virtual_machine_id   = azurerm_linux_virtual_machine.jenkins_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
    "commandToExecute": "chmod 755 /tmp/partition-managed-disk.sh && /tmp/partition-managed-disk.sh"
  }
  SETTINGS
}

resource "azurerm_virtual_machine_extension" "jenkins_extension_2" {
  name                 = "mount-managed-disk"
  virtual_machine_id   = azurerm_linux_virtual_machine.jenkins_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
    "commandToExecute": "chmod 755 /tmp/mount-managed-disk.sh && /tmp/mount-managed-disk.sh"
  }
  SETTINGS
}

resource "azurerm_virtual_machine_extension" "jenkins_extension_3" {
  name                 = "jenkins-installation"
  virtual_machine_id   = azurerm_linux_virtual_machine.jenkins_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
    "commandToExecute": "chmod 755 /tmp/jenkins-installation.sh && /tmp/jenkins-installation.sh"
  }
  SETTINGS
}

# Managed Disk
resource "azurerm_managed_disk" "jenkins_disk" {
  name                 = var.disk_name
  location             = var.location
  resource_group_name  = azurerm_resource_group.jenkins_rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "20"
}

resource "azurerm_virtual_machine_data_disk_attachment" "jenkins_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.jenkins_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.jenkins_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}