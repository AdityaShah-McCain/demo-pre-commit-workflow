resource "azurerm_app_service_plan" "MF_MDI_CC_CORE-LASP" {
    name                    = var.MF_DM_CC_CORE-PRE_PROD-logicappSP_Name
    resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
    location            = azurerm_resource_group.MF_MDI_CC-RG.location
    kind                    = "elastic"
    is_xenon                = "false"
    per_site_scaling        = "false"
    reserved                = "false"
    zone_redundant          = "false"
    sku {
        tier = "WorkflowStandard"
        size = "WS1"
    }
}

resource "azurerm_logic_app_standard" "MF-MDI-CC-CORE-LogicappSAP" {
    name                = var.MF-DM-CC-CORE-PRE-PROD-Logicappsap_Name
    resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
    location            = azurerm_resource_group.MF_MDI_CC-RG.location
    app_service_plan_id         = azurerm_app_service_plan.MF_MDI_CC_CORE-LASP.id
    storage_account_name        = azurerm_storage_account.mfmdicccoresa.name
    storage_account_access_key  = azurerm_storage_account.mfmdicccoresa.primary_access_key


    https_only                  = true
    version                     = "~4"

    site_config {
        always_on                   = false
        dotnet_framework_version    = "v4.0"
        ftps_state                  = "Disabled"
        pre_warmed_instance_count   = "0"
        app_scale_limit             = "1"
    }

    /*app_settings = {
     FUNCTIONS_WORKER_RUNTIME            = "node"
     WEBSITE_NODE_DEFAULT_VERSION        = "~18"
     WEBSITE_RUN_FROM_PACKAGE            = "1"
     WEBSITE_ENABLE_SYNC_UPDATE_SITE     = "true"

    }*/

    identity  {
        type                        = "SystemAssigned"
    }
    lifecycle{
      ignore_changes = [ site_config.0.app_scale_limit, site_config.0.pre_warmed_instance_count ]
    }
}

data "azurerm_managed_api" "sap" {
  name     = "sap"
  location = azurerm_resource_group.MF_MDI_CC-RG.location
}

resource "azapi_resource" "Create_SAP_API_Connection" {
  type      = "Microsoft.Web/connections@2018-07-01-preview"
  name      = "SAPNEW"
  parent_id = azurerm_resource_group.MF_MDI_CC-RG.id
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  schema_validation_enabled = false
  tags      = local.tag_list_1

  body = {
    kind = "V2",
    properties = {
      displayName = "SAPNEW"
      statuses = [
        {
          "status" : "Connected"
        }
      ]
      parameterValueSet: {
        name: "managedIdentityAuth"
        values: {}
      }
      parameterValues       = {
          sncQop= "Authentication",
          sncSso= "On",
          useSnc= "false",
          safeTyping= "false",
          logonType= "ApplicationServer",
          authType= "basic",
          userName= "BTCLGCAPPS",
          password= "LgcApps$0804&S"
          gateway= {
              "name": "PowerPlatform-Azure-Onprem-MDIAI-Datagateway-QA",
              "id": "/subscriptions/6b5fafad-c388-4834-8e16-daf9828deb84/resourceGroups/MF_PowerBI_UAT-RG/providers/Microsoft.Web/connectionGateways/PowerPlatform-Azure-Onprem-MDIAI-Datagateway-QA",
              "type": "Microsoft.Web/connectionGateways"
          },
          client= "200",
          systemNumber= "15",
          messageServerHost= "",
          messageServerService= "",
		      logonGroup= "",
		      systemID= "",
          appServerHost= "sap5sna04.mccain.com"
      }
    //  parameterValues       = {
    //       sncQop= "Authentication",
    //       sncSso= "On",
    //       useSnc= "false",
    //       safeTyping= "false",
    //       logonType= "Group",
    //       authType= "basic",
    //       userName= "BTCLGCAPPS",
    //       password= "PrdLgcApps$0712&D"
    //       gateway= {
    //           "name": "PowerPlatform-Azure-Onprem-MDIAI-Datagateway-Prod",
    //           "id": "/subscriptions/65763622-4bd1-45e6-82fc-2f11e3663439/resourceGroups/MF_PowerBI_Prod-RG/providers/Microsoft.Web/connectionGateways/PowerPlatform-Azure-Onprem-MDIAI-Datagateway-Prod",
    //           "type": "Microsoft.Web/connectionGateways"
    //       },
    //       client= "200",
    //       systemNumber= "",
    //       messageServerHost= "sapcspd01s.mccain.com",
		//       messageServerService= "3610",
		//       logonGroup= "EP1"
		//       systemID= "EP1"
    //       appServerHost= ""
    //   }

      customParameterValues = {}

      api = {
        name        = "sap"
        displayName = "SAP"
        description = "SAP Application Server and Message Server messages"
        iconUri     = "https://connectoricons-prod.azureedge.net/releases/v1.0.1685/1.0.1685.3700/sap/icon.png"
        brandColor  = "#99e7ff"
        category    = "Enterprise"
        id          = data.azurerm_managed_api.sap.id
        type        = "Microsoft.Web/locations/managedApis"
      }
    }
  }
  lifecycle{
    ignore_changes = [ body.properties.api ]
  }
}

data "azapi_resource" "sap_connector" {
    type = "Microsoft.Web/connections@2018-07-01-preview"
    name = "SAPNEW"
    parent_id = azurerm_resource_group.MF_MDI_CC-RG.id
    response_export_values = ["*"]

    depends_on = [
        azapi_resource.Create_SAP_API_Connection
    ]
}

resource "azapi_resource_action" "sap_connector_permission_logic_app" {
    type = "Microsoft.Web/connections@2018-07-01-preview"
    resource_id = data.azapi_resource.sap_connector.id
    action = "accessPolicies/${azurerm_logic_app_standard.MF-MDI-CC-CORE-LogicappSAP.name}"
    response_export_values = ["*"]
    method = "PUT"
    body = {
        properties = {
          principal = {
            type = "ActiveDirectory"
            identity = {
                objectId = azurerm_logic_app_standard.MF-MDI-CC-CORE-LogicappSAP.identity[0].principal_id
                tenantId = azurerm_logic_app_standard.MF-MDI-CC-CORE-LogicappSAP.identity[0].tenant_id
            }
          }
        }
    }
}
