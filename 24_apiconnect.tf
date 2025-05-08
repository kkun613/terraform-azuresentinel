resource "azurerm_api_connection" "smtp" {
  name                = "smtp-con"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  managed_api_id      = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/providers/Microsoft.Web/locations/koreacentral/managedApis/smtp"


  parameter_values = {
    username      = var.smtp_username
    password      = var.smtp_password
    port          = "587"
    enableSSL     = true
    serverAddress = var.smtp_address
  }

}

resource "azurerm_api_connection" "azureblob" {
  name                = "azureblob-con"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  managed_api_id      = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/providers/Microsoft.Web/locations/koreacentral/managedApis/azureblob"

  parameter_values = {
    "accountName" = azurerm_storage_account.ysjang_storage.name
    "accessKey"   = azurerm_key_vault_secret.ysjang_secret.value
  }
}

resource "azurerm_api_connection" "azuresentinel" {
  name                = "azuresentinel-con"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  managed_api_id      = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/providers/Microsoft.Web/locations/koreacentral/managedApis/azuresentinel"

  parameter_values = {
  }
}