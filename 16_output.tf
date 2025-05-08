output "bat_public_ip" {
  value = azurerm_public_ip.ysjang_bat_ip.ip_address
}
output "nat_public_ip" {
  value = azurerm_public_ip.ysjang_nat_ip.ip_address
}
output "appgw_public_ip" {
  value = azurerm_public_ip.ysjang_appgw_ip.ip_address
}

output "vpn_public_ip" {
  value = azurerm_public_ip.ysjang_vpn_ip1.ip_address
}

output "ftp_public_ip" {
  value = azurerm_public_ip.ysjang_ftp_ip.ip_address
}


