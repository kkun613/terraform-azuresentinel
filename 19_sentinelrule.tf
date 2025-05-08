resource "azurerm_sentinel_alert_rule_scheduled" "login_fail_incident" {
  name                       = "login-fail"
  display_name               = "login-fail"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.ysjang_workspace.id
  severity                   = "High"
  query_frequency            = "PT5M"
  query_period               = "PT5M"
  query                      = <<-QUERY
      Syslog
      | where SyslogMessage has "FAIL LOGIN" or SyslogMessage has "FAIL su"
      | summarize FailCount = count() by bin(TimeGenerated, 1m), HostName
      | where TimeGenerated > ago(10m) 
      | where FailCount >= 3
    QUERY
}

resource "azurerm_sentinel_alert_rule_scheduled" "data_incident" {
  name                       = "Data-Exfiltration-Alert"
  display_name               = "Data-Exfiltration-Alert"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.ysjang_workspace.id
  severity                   = "High"
  query_frequency            = "PT5M"
  query_period               = "PT5M"
  query                      = <<-QUERY
AzureNetworkAnalytics_CL
| where FlowDirection_s == "O"
| where DestPort_d == 21 or (DestPort_d between (65000 .. 65100))
| where TimeGenerated > ago(5m)
| summarize PortsUsed = make_set(DestPort_d) by bin(TimeGenerated, 10m), SrcIP_s, DestIP_s
| where array_index_of(PortsUsed, 21) != -1 and array_length(PortsUsed) > 1

    QUERY
}

resource "random_uuid" "container_id" {}

resource "azurerm_sentinel_automation_rule" "auto_loginfail" {
  name                       = "${random_uuid.container_id.result}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.ysjang_workspace.id
  display_name               = "login-fail"
  order                      = 1
  action_playbook {
    order = 1
    logic_app_id = azurerm_logic_app_workflow.login_fail_logicapp.id
  }

  depends_on = [ azurerm_sentinel_log_analytics_workspace_onboarding.ysjang_sentinel ]

}

resource "random_uuid" "container_id1" {}

resource "azurerm_sentinel_automation_rule" "auto_dataexfile" {
    name = "${random_uuid.container_id1.result}"
    log_analytics_workspace_id = azurerm_log_analytics_workspace.ysjang_workspace.id
    display_name = "Data-Exfiltration-Alert"
    order = 1
    action_playbook {
      order = 1
      logic_app_id = azurerm_logic_app_workflow.data_exfile_logicapp.id
    }

    depends_on = [ azurerm_sentinel_log_analytics_workspace_onboarding.ysjang_sentinel ]
  
}