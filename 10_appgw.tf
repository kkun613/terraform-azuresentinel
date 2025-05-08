locals {
  backend_address_pool_name      = "appGatewayBackendPool"
  frontend_port_name             = "port_80"
  frontend_ip_configuration_name = "appGatewayFrontendIP"
  http_setting_name              = "appGatewayBackendHttpSettings"
  listener_name                  = "appGatewayHttpListener"
  request_routing_rule_name      = "appGatewayRule"
}

resource "azurerm_application_gateway" "ysjang_appgw" {
  name                = "ysjang-appgw"
  resource_group_name = azurerm_resource_group.ysjang_rg.name
  location            = azurerm_resource_group.ysjang_rg.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.ysjang_appgw_sub.id
  }
  frontend_port {
    name = local.frontend_port_name
    port = 80
  }
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.ysjang_appgw_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
    ip_addresses = ["192.168.126.21"]
  }
  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }
  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 1
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_http_settings_name = "appGatewayBackendHttpSettings"
    backend_address_pool_name  = "appGatewayBackendPool"
  }

}
