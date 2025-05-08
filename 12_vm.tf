resource "azurerm_linux_virtual_machine" "ysjang_bat_vm" {
  name                  = "ysjang-bat"
  location              = azurerm_resource_group.ysjang_rg.location
  resource_group_name   = azurerm_resource_group.ysjang_rg.name
  size                  = "Standard_B2s"
  admin_username        = "ysjang"
  network_interface_ids = [azurerm_network_interface.ysjang_bat_nic.id]
  admin_ssh_key {
    username   = "ysjang"
    public_key = file("ysjang.pub")
  }

  user_data = base64encode(file("key.sh"))

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-lvm"
    version   = "9.3.20231113"
  }
  plan {
    publisher = "resf"
    product   = "rockylinux-x86_64"
    name      = "9-lvm"
  }
  boot_diagnostics {
    storage_account_uri = null
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /home/ysjang/yml",
      "sudo chown -R ysjang:ysjang /home/ysjang/yml"
    ]

    connection {
      type        = "ssh"
      host        = azurerm_public_ip.ysjang_bat_ip.ip_address
      user        = "ysjang"
      private_key = file("ysjang")
    }
  }

  provisioner "file" {
    source      = "./yml/"
    destination = "/home/ysjang/yml/"
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.ysjang_bat_ip.ip_address
      user        = "ysjang"
      private_key = file("ysjang")

    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y epel-release",
      "sudo dnf install -y ansible",
      "sudo /usr/bin/ansible-playbook /home/ysjang/yml/url.yml",
      "sudo /usr/bin/ansible-playbook /home/ysjang/yml/web1_apache.yml",
      "sudo /usr/bin/ansible-playbook /home/ysjang/yml/web2_nginx.yml",
      "sudo /usr/bin/ansible-playbook /home/ysjang/yml/ftp_install.yml"
    ]

    connection {
      type        = "ssh"
      host        = azurerm_public_ip.ysjang_bat_ip.ip_address
      user        = "ysjang"
      private_key = file("ysjang")
    }
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_linux_virtual_machine.ysjang_ftp_vm]
}

resource "azurerm_linux_virtual_machine" "ysjang_web1_vm" {
  name                  = "ysjang-web1"
  location              = azurerm_resource_group.ysjang_rg.location
  resource_group_name   = azurerm_resource_group.ysjang_rg.name
  size                  = "Standard_B2s"
  admin_username        = "ysjang"
  network_interface_ids = [azurerm_network_interface.ysjang_web1_nic.id]
  user_data             = base64encode(file("selinux.sh"))
  admin_ssh_key {
    username   = "ysjang"
    public_key = file("ysjang.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-lvm"
    version   = "9.3.20231113"
  }
  plan {
    publisher = "resf"
    product   = "rockylinux-x86_64"
    name      = "9-lvm"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_subnet_nat_gateway_association.ysjang_sub_nat_assoc1]

}
resource "azurerm_linux_virtual_machine" "ysjang_web2_vm" {
  name                  = "ysjang-web2"
  location              = azurerm_resource_group.ysjang_rg.location
  resource_group_name   = azurerm_resource_group.ysjang_rg.name
  size                  = "Standard_B2s"
  admin_username        = "ysjang"
  network_interface_ids = [azurerm_network_interface.ysjang_web2_nic.id]
  user_data             = base64encode(file("selinux.sh"))
  admin_ssh_key {
    username   = "ysjang"
    public_key = file("ysjang.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-lvm"
    version   = "9.3.20231113"
  }
  plan {
    publisher = "resf"
    product   = "rockylinux-x86_64"
    name      = "9-lvm"
  }
  boot_diagnostics {
    storage_account_uri = null
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_linux_virtual_machine.ysjang_web1_vm]
}

resource "azurerm_linux_virtual_machine" "ysjang_ftp_vm" {
  name                  = "ysjang-ftp"
  location              = azurerm_resource_group.ysjang_rg.location
  resource_group_name   = azurerm_resource_group.ysjang_rg.name
  size                  = "Standard_B2s"
  admin_username        = "ysjang"
  network_interface_ids = [azurerm_network_interface.ysjang_ftp_nic.id]
  user_data             = base64encode(file("selinux.sh"))
  admin_ssh_key {
    username   = "ysjang"
    public_key = file("ysjang.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-lvm"
    version   = "9.3.20231113"
  }
  plan {
    publisher = "resf"
    product   = "rockylinux-x86_64"
    name      = "9-lvm"
  }
  boot_diagnostics {
    storage_account_uri = null
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_linux_virtual_machine.ysjang_web2_vm]
}
