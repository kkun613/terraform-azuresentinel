resource "random_id" "ysjang_workspace_id" {
  byte_length = 4
}

resource "azurerm_log_analytics_workspace" "ysjang_workspace" {
  name                = "ysjang-workspace-${random_id.ysjang_workspace_id.hex}"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
/*
resource "azurerm_log_analytics_solution" "team1_law_solution" {
  solution_name = "SecurityInsights"
  location = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  workspace_name = azurerm_log_analytics_workspace.ysjang_workspace.name
  workspace_resource_id = azurerm_log_analytics_workspace.ysjang_workspace.id
  plan {
    publisher = "Microsoft"
    product = "OMSGallery/SecurityInsights"
  }
}
*/
resource "azurerm_sentinel_log_analytics_workspace_onboarding" "ysjang_sentinel" {
  workspace_id                 = azurerm_log_analytics_workspace.ysjang_workspace.id
}

resource "azurerm_virtual_machine_extension" "ysjang_ftp_ama" {
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.ysjang_ftp_vm.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.15"
  auto_upgrade_minor_version = true
  #depends_on = [ azurerm_virtual_network_gateway_connection.ysjang_vpncon ]
}

resource "azurerm_virtual_machine_extension" "ysjang_web1_ama" {
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.ysjang_web1_vm.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.15"
  auto_upgrade_minor_version = true
  #depends_on = [ azurerm_virtual_network_gateway_connection.ysjang_vpncon ]
}

resource "azurerm_virtual_machine_extension" "ysjang_web2_ama" {
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.ysjang_web2_vm.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.15"
  auto_upgrade_minor_version = true
  #depends_on = [ azurerm_virtual_network_gateway_connection.ysjang_vpncon ]
}

resource "azurerm_virtual_machine_extension" "ysjang_bat_ama" {
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.ysjang_bat_vm.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.15"
  auto_upgrade_minor_version = true
  #depends_on = [ azurerm_virtual_network_gateway_connection.ysjang_vpncon ]
}