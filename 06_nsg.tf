resource "azurerm_network_security_group" "ysjang_bat_nsg" {
  name                = "ysjang-bat-nsg"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  security_rule {
    name                       = "Allow-All-Inbound"
    priority                   = 999
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "ysjang_web_nsg" {
  name                = "ysjang-web-nsg"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  security_rule {
    name                       = "Allow-All-Inbound"
    priority                   = 998
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "ysjang_ftp_nsg" {
  name                = "ysjang-ftp-nsg"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name

  security_rule {
    name                       = "Allow-All-Inbound"
    priority                   = 997
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
