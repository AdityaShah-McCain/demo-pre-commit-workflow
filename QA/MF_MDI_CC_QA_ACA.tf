
resource "azurerm_container_app_environment" "MF_MDI_CC-CAPPENV" {
  name                           = var.MF_DM_CC-CAPPENV_NAME
  resource_group_name            = azurerm_resource_group.MF_MDI_CC-RG.name
  location                       = azurerm_resource_group.MF_MDI_CC-RG.location
  infrastructure_subnet_id       = azurerm_subnet.MF_MDI_CC_CAPPS-SNET.id
  internal_load_balancer_enabled = true
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.MF_MDI_CC_CORE_LAW.id
}
resource "azurerm_container_app" "MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE" {

  name                         = var.MF_DM_CC-CAPP-MDIAUTHSERVICE_NAME
  container_app_environment_id = azurerm_container_app_environment.MF_MDI_CC-CAPPENV.id
  resource_group_name          = azurerm_resource_group.MF_MDI_CC-RG.name
  revision_mode                = "Single"
  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
  }

  registry {
    server   = var.acr_login_url
    identity = "system"
  }


  template {
    min_replicas = 1
    max_replicas = 10

    container {
      name  = "mdixaiauthservice"
      image = "${var.acr_login_url}/mdixaiauthservice:latest"
      # image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 2.0
      memory = "4Gi"

      env {
        name  = "mdiaikeyVaultName"
        value = "MF-DM-CC-CORE-QA-KV"
      }
      env {
        name = "mdiaiUserAssignedMIClientID"
        value = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
      }

      env {
        name  = "mdiaiTenantId"
        value = "59fa7797-abec-4505-81e6-8ce092642190"
      }
    }
    http_scale_rule {
      name                = "mdiaiauthacascalesetrule"
      concurrent_requests = "10"
    }
    }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    transport                  = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azapi_update_resource" "MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE_SET_CORS" {
  type        = "Microsoft.App/containerApps@2023-05-01"
  resource_id = azurerm_container_app.MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE.id

  body = {
    properties = {
      configuration = {
        # If you have secrets, Do NOT forget to duplicate all secrets here, by specifying var.containerSecrets
        /*secrets = [
          for secretKey, secretValue in var.containerSecrets: {
            name  = secretKey
            value = secretValue
          }
        ]*/
        ingress = {
          corsPolicy = {
            allowedOrigins = ["https://${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}, http://localhost:4200"]
            allowedMethods = ["*"]
            allowedHeaders = ["*"]
          }
        }
      }
    }
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE_pull" {

  scope                = azurerm_container_registry.MF_MDI_CC_CORE_ACR.id
  role_definition_name = "acrpull"
  principal_id = azurerm_container_app.MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE.identity[0].principal_id
  depends_on = [
    azurerm_container_app.MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE
  ]
}

 #                       Daily Direction Setting Service
#############################################################################

resource "azurerm_container_app" "MF_MDI_CC-CAPP-DDDS" {

  name                         = var.MF_DM_CC-QA-CAPP-DDDS_NAME
  container_app_environment_id = azurerm_container_app_environment.MF_MDI_CC-CAPPENV.id
  resource_group_name          = azurerm_resource_group.MF_MDI_CC-RG.name
  revision_mode                = "Single"

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
  }

  registry {
    server   = var.acr_login_url
    identity = "system"
  }


  template {
    min_replicas = 1
    max_replicas = 10

    container {
      name   = "mdixaiddss"
      image  = "${var.acr_login_url}/mdixaiddss:latest"
      # image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 2.0
      memory = "4Gi"

      env {
        name  = "mdiaikeyVaultName"
        value = "MF-DM-CC-CORE-QA-KV"
      }
      env {
        name = "mdiaiUserAssignedMIClientID"
        value = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
      }

      env {
        name  = "mdiaiTenantId"
        value = "59fa7797-abec-4505-81e6-8ce092642190"
      }
      env {
        name = "KpiViewClearDuration"
        value = "60"
      }
    }
    http_scale_rule {
      name = "mdiaiddssacascalesetrule"
      concurrent_requests = "10"
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    transport                  = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azapi_update_resource" "MF_MDI_CC-CAPP-DDDS_SET_CORS" {
  type        = "Microsoft.App/containerApps@2023-05-01"
  resource_id = azurerm_container_app.MF_MDI_CC-CAPP-DDDS.id

  body = {
    properties = {
      configuration = {
       # If you have secrets, Do NOT forget to duplicate all secrets here, by specifying var.containerSecrets
        /*secrets = [
          for secretKey, secretValue in var.containerSecrets: {
            name  = secretKey
            value = secretValue
          }
        ]*/
        ingress = {
          corsPolicy = {
            allowedOrigins = ["https://${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}, http://localhost:4200"]
            allowedMethods = ["*"]
            allowedHeaders = ["*"]
          }
        }
      }
    }
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC-CAPP-DDDS_pull" {
  scope = azurerm_container_registry.MF_MDI_CC_CORE_ACR.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-DDDS.identity[0].principal_id
    depends_on = [
   azurerm_container_app.MF_MDI_CC-CAPP-DDDS
  ]
 }

#                       Defect Handling Service
#############################################################################
resource "azurerm_container_app" "MF_MDI_CC-CAPP-ddh" {
  name                         = var.MF_DM_CC-CAPP-ddh_NAME
  container_app_environment_id = azurerm_container_app_environment.MF_MDI_CC-CAPPENV.id
  resource_group_name          = azurerm_resource_group.MF_MDI_CC-RG.name
  revision_mode                = "Single"

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
  }

  registry {
    server   = var.acr_login_url
    identity = "system"
  }


  template {
    min_replicas = 1
    max_replicas = 10

    container {
      name  = "mdixaiddh"
      image = "${var.acr_login_url}/mdixaiddh:latest"
      #  image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 2.0
      memory = "4Gi"

      env {
        name  = "mdiaikeyVaultName"
        value = "MF-DM-CC-CORE-QA-KV"
      }
      env {
        name = "mdiaiUserAssignedMIClientID"
        value = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
      }

      env {
        name  = "mdiaiTenantId"
        value = "59fa7797-abec-4505-81e6-8ce092642190"
      }
    }
    http_scale_rule {
      name                = "mdiaiddhacascalesetrule"
      concurrent_requests = "10"
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    transport                  = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azapi_update_resource" "MF_MDI_CC-CAPP-ddh_SET_CORS" {
  type        = "Microsoft.App/containerApps@2023-05-01"
  resource_id = azurerm_container_app.MF_MDI_CC-CAPP-ddh.id

  body = {
    properties = {
      configuration = {
        # If you have secrets, Do NOT forget to duplicate all secrets here, by specifying var.containerSecrets
        /*secrets = [
          for secretKey, secretValue in var.containerSecrets: {
            name  = secretKey
            value = secretValue
          }
        ]*/
        ingress = {
          corsPolicy = {
            allowedOrigins = ["https://${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}, http://localhost:4200"]
            allowedMethods = ["*"]
            allowedHeaders = ["*"]
          }
        }
      }
    }
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC-CAPP-ddh_pull" {
  scope                = azurerm_container_registry.MF_MDI_CC_CORE_ACR.id
  role_definition_name = "acrpull"
  principal_id = azurerm_container_app.MF_MDI_CC-CAPP-ddh.identity[0].principal_id
  depends_on = [
    azurerm_container_app.MF_MDI_CC-CAPP-ddh
  ]
}

 #                       DCL
#############################################################################
resource "azurerm_container_app" "MF_MDI_CC-CAPP-dcl" {
  name                         = var.MF_DM_CC-QA-CAPP-dcl_NAME
  container_app_environment_id = azurerm_container_app_environment.MF_MDI_CC-CAPPENV.id
  resource_group_name          = azurerm_resource_group.MF_MDI_CC-RG.name
  revision_mode                = "Single"

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
  }

  registry {
    server   = var.acr_login_url
    identity = "system"
  }


  template {
    min_replicas = 1
    max_replicas = 10

    container {
      name   = "mdixaidcl"
      image  = "${var.acr_login_url}/mdixaidcl:latest"
      # image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 2.0
      memory = "4Gi"

      env {
        name  = "mdiaikeyVaultName"
        value = "MF-DM-CC-CORE-QA-KV"
      }
      env {
        name = "mdiaiUserAssignedMIClientID"
        value = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
      }

      env {
        name  = "mdiaiTenantId"
        value = "59fa7797-abec-4505-81e6-8ce092642190"
      }
    }
    http_scale_rule {
      name = "mdiaidclacascalesetrule"
      concurrent_requests = "10"
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    transport                  = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azapi_update_resource" "MF_MDI_CC-CAPP-dcl_SET_CORS" {
  type        = "Microsoft.App/containerApps@2023-05-01"
  resource_id = azurerm_container_app.MF_MDI_CC-CAPP-dcl.id

  body = {
    properties = {
      configuration = {
       # If you have secrets, Do NOT forget to duplicate all secrets here, by specifying var.containerSecrets
        /*secrets = [
          for secretKey, secretValue in var.containerSecrets: {
            name  = secretKey
            value = secretValue
          }
        ]*/
        ingress = {
          corsPolicy = {
            allowedOrigins = ["https://${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}, http://localhost:4200"]
            allowedMethods = ["*"]
            allowedHeaders = ["*"]
          }
        }
      }
    }
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC-CAPP-dcl_pull" {
  scope = azurerm_container_registry.MF_MDI_CC_CORE_ACR.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-dcl.identity[0].principal_id
    depends_on = [
   azurerm_container_app.MF_MDI_CC-CAPP-dcl
  ]
 }
#                       CID
#############################################################################
resource "azurerm_container_app" "MF_MDI_CC-CAPP-cid" {
  name                         = var.MF_DM_CC-QA-CAPP-cid_NAME
  container_app_environment_id = azurerm_container_app_environment.MF_MDI_CC-CAPPENV.id
  resource_group_name          = azurerm_resource_group.MF_MDI_CC-RG.name
  revision_mode                = "Single"

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
  }

  registry {
    server   = var.acr_login_url
    identity = "system"
  }


  template {
    min_replicas = 1
    max_replicas = 10

    container {
      name   = "mdixaicid"
      image  = "${var.acr_login_url}/mdixaicid:latest"
      # image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 2.0
      memory = "4Gi"

      env {
        name  = "mdiaikeyVaultName"
        value = "MF-DM-CC-CORE-QA-KV"
      }
      env {
        name = "mdiaiUserAssignedMIClientID"
        value = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
      }

      env {
        name  = "mdiaiTenantId"
        value = "59fa7797-abec-4505-81e6-8ce092642190"
      }
    }
    http_scale_rule {
      name = "mdiaicidacascalesetrule"
      concurrent_requests = "10"
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    transport                  = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azapi_update_resource" "MF_MDI_CC-CAPP-cid_SET_CORS" {
  type        = "Microsoft.App/containerApps@2023-05-01"
  resource_id = azurerm_container_app.MF_MDI_CC-CAPP-cid.id

  body = {
    properties = {
      configuration = {
       # If you have secrets, Do NOT forget to duplicate all secrets here, by specifying var.containerSecrets
        /*secrets = [
          for secretKey, secretValue in var.containerSecrets: {
            name  = secretKey
            value = secretValue
          }
        ]*/
        ingress = {
          corsPolicy = {
            allowedOrigins = ["https://${var.cc_core_apim_api_a_record}.${var.cc_core_domain_name}, http://localhost:4200"]
            allowedMethods = ["*"]
            allowedHeaders = ["*"]
          }
        }
      }
    }
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC-CAPP-cid_pull" {
  scope = azurerm_container_registry.MF_MDI_CC_CORE_ACR.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-cid.identity[0].principal_id
    depends_on = [
   azurerm_container_app.MF_MDI_CC-CAPP-cid
  ]
 }
