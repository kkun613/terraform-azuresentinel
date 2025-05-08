resource "azurerm_network_interface_security_group_association" "ysjang_nic_nsg" {
  network_interface_id      = azurerm_network_interface.ysjang_bat_nic.id
  network_security_group_id = azurerm_network_security_group.ysjang_bat_nsg.id
}

resource "azurerm_network_interface_security_group_association" "ysjang_web1_nic_nsg" {
  network_interface_id      = azurerm_network_interface.ysjang_web1_nic.id
  network_security_group_id = azurerm_network_security_group.ysjang_web_nsg.id
}

resource "azurerm_network_interface_security_group_association" "ysjang_web2_nic_nsg" {
  network_interface_id      = azurerm_network_interface.ysjang_web2_nic.id
  network_security_group_id = azurerm_network_security_group.ysjang_web_nsg.id
}

resource "azurerm_network_interface_security_group_association" "ysjang_ftp_nic_nsg" {
  network_interface_id      = azurerm_network_interface.ysjang_ftp_nic.id
  network_security_group_id = azurerm_network_security_group.ysjang_ftp_nsg.id  
}