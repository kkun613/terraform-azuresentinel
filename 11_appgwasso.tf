resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "ysjang_web1_nic_appgw" {
  network_interface_id            = azurerm_network_interface.ysjang_web1_nic.id
  backend_address_pool_id         = tolist(azurerm_application_gateway.ysjang_appgw.backend_address_pool)[0].id
  ip_configuration_name = "ysjang-web1-ipconfig"
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "ysjang_web2_nic_appgw" {
  network_interface_id            = azurerm_network_interface.ysjang_web2_nic.id
  backend_address_pool_id         = tolist(azurerm_application_gateway.ysjang_appgw.backend_address_pool)[0].id
  ip_configuration_name = "ysjang-web2-ipconfig"
}