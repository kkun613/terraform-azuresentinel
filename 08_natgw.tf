resource "azurerm_nat_gateway" "ysjang_nat" {
  name                = "ysjang-nat"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  location            = azurerm_resource_group.ysjang_rg.location
  sku_name            = "Standard"
}

resource "azurerm_subnet_nat_gateway_association" "ysjang_sub_nat_assoc" {
  subnet_id      = azurerm_subnet.ysjang_nat_sub.id
  nat_gateway_id = azurerm_nat_gateway.ysjang_nat.id
  depends_on = [ azurerm_nat_gateway_public_ip_association.ysjang_nat_ip_asso ]
}

resource "azurerm_nat_gateway_public_ip_association" "ysjang_nat_ip_asso" {
  nat_gateway_id       = azurerm_nat_gateway.ysjang_nat.id
  public_ip_address_id = azurerm_public_ip.ysjang_nat_ip.id
  depends_on = [ azurerm_nat_gateway.ysjang_nat , azurerm_public_ip.ysjang_nat_ip ]
}

resource "azurerm_subnet_nat_gateway_association" "ysjang_sub_nat_assoc1" {
  subnet_id      = azurerm_subnet.ysjang_web1_sub.id
  nat_gateway_id = azurerm_nat_gateway.ysjang_nat.id
  depends_on = [ azurerm_nat_gateway_public_ip_association.ysjang_nat_ip_asso ]
}

resource "azurerm_subnet_nat_gateway_association" "ysjang_sub_nat_assoc2" {
  subnet_id      = azurerm_subnet.ysjang_web2_sub.id
  nat_gateway_id = azurerm_nat_gateway.ysjang_nat.id
  depends_on = [ azurerm_nat_gateway_public_ip_association.ysjang_nat_ip_asso ]
}

resource "azurerm_subnet_nat_gateway_association" "ysjang_sub_nat_assoc3" {
  subnet_id      = azurerm_subnet.ysjang_ftp_sub.id
  nat_gateway_id = azurerm_nat_gateway.ysjang_nat.id
  depends_on = [ azurerm_nat_gateway_public_ip_association.ysjang_nat_ip_asso ]  
}
