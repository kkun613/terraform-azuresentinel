resource "azurerm_network_interface" "ysjang_bat_nic" {
  name                = "ysjang-bat-nic"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name

  ip_configuration {
    name                          = "ysjang-bat-ipconfig"
    subnet_id                     = azurerm_subnet.ysjang_bat_sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ysjang_bat_ip.id
  }
}

resource "azurerm_network_interface" "ysjang_web1_nic" {
  name                = "ysjang-web1-nic"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name

  ip_configuration {
    name                          = "ysjang-web1-ipconfig"
    subnet_id                     = azurerm_subnet.ysjang_web1_sub.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ azurerm_subnet_nat_gateway_association.ysjang_sub_nat_assoc1 ]
}

resource "azurerm_network_interface" "ysjang_web2_nic" {
  name                = "ysjang-web2-nic"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name

  ip_configuration {
    name                          = "ysjang-web2-ipconfig"
    subnet_id                     = azurerm_subnet.ysjang_web2_sub.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ azurerm_subnet_nat_gateway_association.ysjang_sub_nat_assoc2 ]
}

resource "azurerm_network_interface" "ysjang_ftp_nic" {
  name                = "ysjang-ftp-nic"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name

  ip_configuration {
    name                          = "ysjang-ftp-ipconfig"
    subnet_id                     = azurerm_subnet.ysjang_ftp_sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.ysjang_ftp_ip.id
  }
  depends_on = [ azurerm_subnet_nat_gateway_association.ysjang_sub_nat_assoc3 ]
  
}