resource "azurerm_dns_zone" "ysjang_dns" {
  name                = "kkun.store"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
}

resource "azurerm_dns_zone" "ysjang_dns1" {
  name                = "westkite.store"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
}

resource "azurerm_dns_zone" "ysjang_dns2" {
  name                = "hunny201.shop"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
}

