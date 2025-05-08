resource "azurerm_public_ip" "ysjang_bat_ip" {
  name                 = "ysjang-bat-ip"
  location             = azurerm_resource_group.ysjang_rg.location
  resource_group_name  = azurerm_resource_group.ysjang_rg.name
  allocation_method    = "Static"
  sku                  = "Standard"
  ip_version           = "IPv4"
  ddos_protection_mode = "Disabled"
}

resource "azurerm_public_ip" "ysjang_nat_ip" {
  name                 = "ysjang-nat-ip"
  location             = azurerm_resource_group.ysjang_rg.location
  resource_group_name  = azurerm_resource_group.ysjang_rg.name
  allocation_method    = "Static"
  sku                  = "Standard"
  ip_version           = "IPv4"
  ddos_protection_mode = "Disabled"
}

resource "azurerm_public_ip" "ysjang_ftp_ip" {
  name                 = "ysjang-ftp-ip"
  location             = azurerm_resource_group.ysjang_rg.location
  resource_group_name  = azurerm_resource_group.ysjang_rg.name
  allocation_method    = "Static"
  sku                  = "Standard"
  ip_version           = "IPv4"
  ddos_protection_mode = "Disabled"
  
}

resource "azurerm_public_ip" "ysjang_appgw_ip" {
  name                 = "ysjang-appgw-ip"
  location             = azurerm_resource_group.ysjang_rg.location
  resource_group_name  = azurerm_resource_group.ysjang_rg.name
  allocation_method    = "Static"
  sku                  = "Standard"
  ip_version           = "IPv4"
  ddos_protection_mode = "Disabled"
}

resource "azurerm_public_ip" "ysjang_vpn_ip1" {
  name                 = "ysjang-vpn-ip1"
  location             = azurerm_resource_group.ysjang_rg.location
  resource_group_name  = azurerm_resource_group.ysjang_rg.name
  allocation_method    = "Static"
  sku                  = "Standard"
  ip_version           = "IPv4"
  ddos_protection_mode = "Disabled"
  zones                = ["1", "2", "3"]
}
