
resource "azurerm_storage_account" "ysjang_storage" {
  name                     = "ysjangstorage1188"
  resource_group_name      = azurerm_resource_group.ysjang_rg.name
  location                 = azurerm_resource_group.ysjang_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  https_traffic_only_enabled = true
}


resource "azurerm_storage_container" "ysjang_container" {
  name                  = "ysjang-container"
  storage_account_id  = azurerm_storage_account.ysjang_storage.id
  container_access_type = "private"
}

resource "random_id" "kv_id" {
  byte_length = 4
}

data "azurerm_client_config" "current" {}
  

resource "azurerm_key_vault" "ysjang_kv" {
  name                = "ysjang-kv-${random_id.kv_id.hex}"
  location            = azurerm_resource_group.ysjang_rg.location
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled = true
  enabled_for_disk_encryption = true
  enable_rbac_authorization = true
}

resource "azurerm_key_vault_secret" "ysjang_secret" {
  name         = "ysjang-access-key"
  value = azurerm_storage_account.ysjang_storage.primary_access_key
  key_vault_id = azurerm_key_vault.ysjang_kv.id

  depends_on = [ azurerm_key_vault.ysjang_kv ]
}

resource "azurerm_role_assignment" "ysjang_kv_access" {
  principal_id   = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Administrator"
  scope          = azurerm_key_vault.ysjang_kv.id

  depends_on = [ azurerm_key_vault.ysjang_kv ]
  
}

resource "azurerm_role_assignment" "logicapp_runlogin" {
  scope = azurerm_logic_app_workflow.login_fail_logicapp.id
  role_definition_name = "Logic App Operator"
  principal_id = data.azurerm_client_config.current.object_id
  
}

resource "azurerm_role_assignment" "logicapp_rundataexfile" {
  scope = azurerm_logic_app_workflow.data_exfile_logicapp.id
  role_definition_name = "Logic App Operator"
  principal_id = data.azurerm_client_config.current.object_id
  
}