
resource "azurerm_subnet" "ysjang_kali_sub" {
  name                            = "ysjang-kali"
  resource_group_name             = azurerm_resource_group.ysjang_rg.name
  virtual_network_name            = azurerm_virtual_network.ysjang_vnet.name
  address_prefixes                = ["10.0.10.0/24"]
  default_outbound_access_enabled = true
}

resource "azurerm_network_security_group" "ysjang_kali_nsg" {
  name                = "ysjang-kali-nsg"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  security_rule {
    name                       = "Allow-All-Inbound"
    priority                   = 996
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "ysjang_kali_nic_nsg" {
  network_interface_id      = azurerm_network_interface.ysjang_kali_nic.id
  network_security_group_id = azurerm_network_security_group.ysjang_kali_nsg.id
}

resource "azurerm_network_interface" "ysjang_kali_nic" {
  name                = "ysjang-kali-nic"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name

  ip_configuration {
    name                          = "ysjang-kali-ipconfig"
    subnet_id                     = azurerm_subnet.ysjang_kali_sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ysjang_kali_ip.id
  }
}

resource "azurerm_public_ip" "ysjang_kali_ip" {
  name                 = "ysjang-kali-ip"
  location             = azurerm_resource_group.ysjang_rg.location
  resource_group_name  = azurerm_resource_group.ysjang_rg.name
  allocation_method    = "Static"
  sku                  = "Standard"
  ip_version           = "IPv4"
  ddos_protection_mode = "Disabled"
}

resource "azurerm_linux_virtual_machine" "ysjang_kali_vm" {
  name                  = "ysjang-kali"
  location              = azurerm_resource_group.ysjang_rg.location
  resource_group_name   = azurerm_resource_group.ysjang_rg.name
  size                  = "Standard_B2s"
  admin_username        = "ysjang"
  network_interface_ids = [azurerm_network_interface.ysjang_kali_nic.id]
  admin_ssh_key {
    username   = "ysjang"
    public_key = file("ysjang.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "kali-linux"
    offer     = "kali"
    sku       = "kali-2024-2"
    version   = "2024.2.0"
  }
  plan {
    publisher = "kali-linux"
    product   = "kali"
    name      = "kali-2024-2"
  }
  boot_diagnostics {
    storage_account_uri = null
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kali_public_ip" {
  value = azurerm_public_ip.ysjang_kali_ip.ip_address
}
