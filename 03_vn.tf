resource "azurerm_virtual_network" "ysjang_vnet" {
  name                = "ysjang-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
}
