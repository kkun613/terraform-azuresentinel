data "azurerm_subscription" "current" {}

locals {
  connection_string = format(
    "DefaultEndpointsProtocol=https;AccountName=%s;AccountKey=%s;EndpointSuffix=core.windows.net",
    azurerm_storage_account.ysjang_storage.name,
    azurerm_storage_account.ysjang_storage.primary_access_key
  )
}

resource "azurerm_logic_app_workflow" "login_fail_logicapp" {
  name                = "ysjang-login-fail"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  enabled             = true

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_logic_app_workflow" "data_exfile_logicapp" {
  name                = "ysjang-data-exfile"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  enabled             = true

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "logicapp_nsg" {
  principal_id         = azurerm_logic_app_workflow.data_exfile_logicapp.identity[0].principal_id
  role_definition_name = "Network Contributor"
  scope                = azurerm_network_security_group.ysjang_ftp_nsg.id
  depends_on           = [azurerm_logic_app_workflow.data_exfile_logicapp]
}



resource "azurerm_role_assignment" "logicapp_vm_dataexfile" {
  principal_id         = azurerm_logic_app_workflow.data_exfile_logicapp.identity[0].principal_id
  role_definition_name = "Virtual Machine Contributor"
  scope                = azurerm_linux_virtual_machine.ysjang_ftp_vm.id
  depends_on           = [azurerm_logic_app_workflow.data_exfile_logicapp]
}

resource "azurerm_role_assignment" "logicapp_vm_loginfail" {
  principal_id         = azurerm_logic_app_workflow.login_fail_logicapp.identity[0].principal_id
  role_definition_name = "Virtual Machine Contributor"
  scope                = azurerm_linux_virtual_machine.ysjang_ftp_vm.id
  depends_on           = [azurerm_logic_app_workflow.login_fail_logicapp]
}

resource "azurerm_role_assignment" "logicapp_blob" {
  principal_id         = azurerm_logic_app_workflow.data_exfile_logicapp.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.ysjang_storage.id
  depends_on           = [azurerm_logic_app_workflow.data_exfile_logicapp]
}

resource "azurerm_role_assignment" "logicapp_sentinel" {
  principal_id         = azurerm_logic_app_workflow.data_exfile_logicapp.identity[0].principal_id
  role_definition_name = "Microsoft Sentinel Contributor"
  scope                = azurerm_resource_group.ysjang_rg.id
  depends_on           = [azurerm_logic_app_workflow.data_exfile_logicapp]
}

resource "azurerm_role_assignment" "logicapp_sentinel1" {
  principal_id         = azurerm_logic_app_workflow.login_fail_logicapp.identity[0].principal_id
  role_definition_name = "Microsoft Sentinel Contributor"
  scope                = azurerm_resource_group.ysjang_rg.id
  depends_on           = [azurerm_logic_app_workflow.data_exfile_logicapp]
}

resource "azurerm_resource_group_template_deployment" "loginfail_definition" {
  name                = "loginfail_definition"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/logicapp_loginfail.json")

  parameters_content = jsonencode({
    logicAppName = {
      value = azurerm_logic_app_workflow.login_fail_logicapp.name
    }
  })
  depends_on = [azurerm_api_connection.smtp, azurerm_logic_app_workflow.login_fail_logicapp, azurerm_api_connection.azureblob]
}

resource "azurerm_resource_group_template_deployment" "dataexfil_definition" {
  name                = "dataexfil_definition"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/logicapp_dataexfil.json")

  parameters_content = jsonencode({
    logicAppName = {
      value = azurerm_logic_app_workflow.data_exfile_logicapp.name
    }
    vmResourceId = {
      value = azurerm_linux_virtual_machine.ysjang_ftp_vm.id
    }
    nsgResourceId = {
      value = azurerm_network_security_group.ysjang_ftp_nsg.id
    }
    storageAccountName = {
      value = azurerm_storage_account.ysjang_storage.name
    }
  })
  depends_on = [azurerm_api_connection.smtp, azurerm_logic_app_workflow.data_exfile_logicapp, azurerm_api_connection.azureblob]
}

