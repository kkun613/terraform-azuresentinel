resource "azurerm_monitor_data_collection_endpoint" "ysjang_dce" {
  name                          = "ysjang-dce"
  resource_group_name           = azurerm_resource_group.ysjang_rg.name
  location                      = azurerm_resource_group.ysjang_rg.location
  kind                          = "Linux"
}

resource "azurerm_monitor_data_collection_rule" "ysjang_dcr" {
  name                        = "ysjang-dcr"
  resource_group_name         = azurerm_resource_group.ysjang_rg.name
  location                    = azurerm_resource_group.ysjang_rg.location
  kind                        = "Linux"
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.ysjang_dce.id

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.ysjang_workspace.id
      name                  = "ysjang-log-analytics"
    }
  }

  data_sources {
    syslog {
      name           = "syslogSource"
      streams        = ["Microsoft-Syslog"]
      log_levels     = ["Info", "Warning", "Error", "Critical", "Notice"]
      facility_names = ["*"]
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["ysjang-log-analytics"]
    output_stream = "Microsoft-Syslog"
  }
  depends_on = [ azurerm_monitor_data_collection_endpoint.ysjang_dce ]
}


resource "azurerm_monitor_data_collection_rule_association" "ftp_dca" {
  name                    = "ysjang-ftp-dca"
  target_resource_id      = azurerm_linux_virtual_machine.ysjang_ftp_vm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.ysjang_dcr.id
  depends_on = [ azurerm_virtual_machine_extension.ysjang_ftp_ama, azurerm_monitor_data_collection_rule.ysjang_dcr ]
}

resource "azurerm_monitor_data_collection_rule_association" "ysjang_web1_dca" {
  name                    = "ysjang-web1-dca"
  target_resource_id      = azurerm_linux_virtual_machine.ysjang_web1_vm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.ysjang_dcr.id
  depends_on = [ azurerm_virtual_machine_extension.ysjang_web1_ama, azurerm_monitor_data_collection_rule.ysjang_dcr ]

}

resource "azurerm_monitor_data_collection_rule_association" "ysjang_web2_dca" {
  name                    = "ysjang-web2-dca"
  target_resource_id      = azurerm_linux_virtual_machine.ysjang_web2_vm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.ysjang_dcr.id
  depends_on = [ azurerm_virtual_machine_extension.ysjang_web2_ama, azurerm_monitor_data_collection_rule.ysjang_dcr ]

}

resource "azurerm_monitor_data_collection_rule_association" "ysjang_bat_dca" {
  name                    = "ysjang-bat-dca"
  target_resource_id      = azurerm_linux_virtual_machine.ysjang_bat_vm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.ysjang_dcr.id
  depends_on = [ azurerm_virtual_machine_extension.ysjang_bat_ama, azurerm_monitor_data_collection_rule.ysjang_dcr ]

}
