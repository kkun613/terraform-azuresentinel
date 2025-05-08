/*
resource "azurerm_network_watcher" "ysjang_nw" {
  name                = "ysjang-networkwatcher"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
}
*/

data "azurerm_network_watcher" "existing" {
  name                = "NetworkWatcher_koreacentral"
  resource_group_name = "NetworkWatcherRG"

}

resource "azurerm_network_watcher_flow_log" "ysjang_nsg_flow_log" {
  network_watcher_name = data.azurerm_network_watcher.existing.name
  resource_group_name  = data.azurerm_network_watcher.existing.resource_group_name
  name                 = "team-nsg-flow-log"
  location             = azurerm_resource_group.ysjang_rg.location

  target_resource_id = azurerm_network_security_group.ysjang_ftp_nsg.id
  storage_account_id = azurerm_storage_account.ysjang_storage.id
  enabled            = true

  retention_policy {
    enabled = true
    days    = 7
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.ysjang_workspace.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.ysjang_workspace.location
    workspace_resource_id = azurerm_log_analytics_workspace.ysjang_workspace.id
    interval_in_minutes   = 10
  }
  depends_on = [
    azurerm_storage_account.ysjang_storage,
    azurerm_network_security_group.ysjang_ftp_nsg,
    azurerm_log_analytics_workspace.ysjang_workspace
  ]
}
