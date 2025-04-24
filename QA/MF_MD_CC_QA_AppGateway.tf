#/*
#data "azurerm_key_vault" "MF_DM_CC_CORE_DEV-KEY-VAULT"{
# provider = azurerm.MF-Core-Infrastructure-DEV-Subscription
# name = "MF_DM_CC_CORE_DEV-KEY-VAULT"
# resource_group_name = azurerm_resource_group.MF_DM_CC-RG.name
#}
#*/

data "azurerm_key_vault_certificate" "MF-DM-CORE-APPGWKV-SSL-CERT" {
  name         = var.cc_core_appgw_kv_certificate
  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
}

data "azurerm_key_vault_secret" "MF-DM-CORE-APPGWKV-CER" {
  name         = var.cc_core_appgw_kv_certificate-cer
  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
}

# ###############   Application Gateway    ##############

resource "azurerm_user_assigned_identity" "MF_MDI_CC_CORE_APPGW-USER-IDENTITY" {
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  name                = var.cc_core_appgw_user_identity
  # lifecycle {
  #   prevent_destroy   = true
  # }
    # tags = local.tag_list_1
  tags                  = local.tag_list_1
}
resource "azurerm_application_gateway" "MF_MDI_CC_APPGW" {
  name                = var.MF_DM_CC_APPGW_Name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location

  sku {
    name = var.cc_core_appgw_sku
    tier = var.cc_core_appgw_tier
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY.id]
  }

  autoscale_configuration {
    min_capacity = "1"
    max_capacity = "2"
  }

  gateway_ip_configuration {
    name      = "appgateway-ip-config"
    subnet_id = azurerm_subnet.MF_MDI_CC_APPGW-SNET.id
  }
  frontend_port {
    name = "appgateway-frontendport"
    port = 443
  }
  frontend_ip_configuration {
    name                 = "appgateway-frontendipconfig"
    public_ip_address_id = azurerm_public_ip.appgw-public-ip.id

  }

  backend_address_pool {
    name  = "webuibackendpool"
    fqdns = ["${var.cc_core_web_ui_a_record}"] ### - A list of FQDN's which should be part of the Backend Address Pool.
    ### ip_address = data.GET.private_ip_addresses
  }
  backend_address_pool {
    name  = "apimbackendpool"
    fqdns = ["${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}"] ### - A list of FQDN's which should be part of the Backend Address Pool.
    ### ip_address = data.GET.private_ip_addresses
  }


  backend_http_settings {
    name = "mdixaiappgwbackendsettings"
    #host_name             = "${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 10
    probe_name                          = "${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}-probe"
    pick_host_name_from_backend_address = true
    #trusted_root_certificate_names = ["${data.azurerm_key_vault_secret.MF-DM-CORE-DEV-APPGWKV-CER.name}"]
  }


  ssl_certificate { # must be updated with valid details
    name                = data.azurerm_key_vault_certificate.MF-DM-CORE-APPGWKV-SSL-CERT.name
    key_vault_secret_id = data.azurerm_key_vault_certificate.MF-DM-CORE-APPGWKV-SSL-CERT.versionless_secret_id
  }

  trusted_root_certificate {
    name                = data.azurerm_key_vault_secret.MF-DM-CORE-APPGWKV-CER.name
    key_vault_secret_id = data.azurerm_key_vault_secret.MF-DM-CORE-APPGWKV-CER.versionless_id
  }
  http_listener {
    name                           = "mdixailistener"
    frontend_ip_configuration_name = "appgateway-frontendipconfig"
    frontend_port_name             = "appgateway-frontendport"
    protocol                       = "Https"
    ssl_certificate_name           = var.cc_core_appgw_kv_certificate
  }

  request_routing_rule {

    name                       = "mdixairoutingrule"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "mdixailistener"
    backend_address_pool_name  = "webuibackendpool"
    backend_http_settings_name = "mdixaiappgwbackendsettings"
    priority                   = 1
    url_path_map_name          = "qamdixai"
  }

  url_path_map {
    name                               = "qamdixai"
    default_backend_address_pool_name  = "webuibackendpool"
    default_backend_http_settings_name = "mdixaiappgwbackendsettings"

    path_rule {
      name                       = "webui"
      paths                      = ["/mdiaiuiqa*"]
      backend_address_pool_name  = "webuibackendpool"
      backend_http_settings_name = "mdixaiappgwbackendsettings"

    }

    path_rule {
      name                       = "apitarget"
      paths                      = ["/mdiaiapiqa*"]
      backend_address_pool_name  = "apimbackendpool"
      backend_http_settings_name = "mdixaiappgwbackendsettings"

    }
  }


  probe {
    #host                ="${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}"
    name                                      = "${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}-probe"
    protocol                                  = "Https"
    path                                      = "/status-0123456789abcdef" #####replace this with actual path to your health check endpoint.
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

    match {
      status_code = ["200-999"]
    }
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [request_routing_rule]
  }
}

########################  Public Ip and domain label name  ######################

resource "azurerm_public_ip" "appgw-public-ip" {
  name                = var.appgw-public-ip_NAME
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  allocation_method   = "Static"
  sku                 = var.cc_core_public_ip_sku
  #domain_name_label   = "mccain831234567"
}
