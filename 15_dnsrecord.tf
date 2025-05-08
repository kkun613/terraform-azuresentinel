resource "azurerm_dns_a_record" "ysjang_www" {
  name = "www"
  zone_name = azurerm_dns_zone.ysjang_dns.name
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  ttl = 300
  records = [azurerm_public_ip.ysjang_appgw_ip.ip_address]
}

resource "azurerm_dns_a_record" "ysjang_root" {
  name = "@"
  zone_name = azurerm_dns_zone.ysjang_dns.name
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  ttl = 300
  records = [azurerm_public_ip.ysjang_appgw_ip.ip_address]
}

resource "azurerm_dns_a_record" "ysjang_www1" {
  name = "www"
  zone_name = azurerm_dns_zone.ysjang_dns1.name
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  ttl = 300
  records = [azurerm_public_ip.ysjang_appgw_ip.ip_address]
}

resource "azurerm_dns_a_record" "ysjang_root1" {
  name = "@"
  zone_name = azurerm_dns_zone.ysjang_dns1.name
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  ttl = 300
  records = [azurerm_public_ip.ysjang_appgw_ip.ip_address]
}

resource "azurerm_dns_a_record" "ysjang_www2" {
  name = "www"
  zone_name = azurerm_dns_zone.ysjang_dns2.name
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  ttl = 300
  records = [azurerm_public_ip.ysjang_appgw_ip.ip_address]
}

resource "azurerm_dns_a_record" "ysjang_root2" {
  name = "@"
  zone_name = azurerm_dns_zone.ysjang_dns2.name
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  ttl = 300
  records = [azurerm_public_ip.ysjang_appgw_ip.ip_address]
}
