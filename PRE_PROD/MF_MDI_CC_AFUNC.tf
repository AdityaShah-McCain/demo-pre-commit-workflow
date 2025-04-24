resource "azurerm_app_service_plan" "MFDMCCASPAFUNC" {
 name                = "MFDMCCPREPRODASPAFUNC"
    resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
    location            = azurerm_resource_group.MF_MDI_CC-RG.location
 kind                = "FunctionApp"
 sku {
   tier = "PremiumV2"
   size = "P1v2"
 }
}

resource "azurerm_function_app" "MF-MDI-CC-DDDS-AFUNC" {
 name                       = "MF-DM-CC-PRE-PROD-DDDS-AFUNC"
    resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
    location            = azurerm_resource_group.MF_MDI_CC-RG.location
 app_service_plan_id        = azurerm_app_service_plan.MFDMCCASPAFUNC.id
 storage_account_name       = azurerm_storage_account.mfmdicccoresa.name
 storage_account_access_key = azurerm_storage_account.mfmdicccoresa.primary_access_key
 version                    = "~4"
 identity  {
        type                = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
    }
    site_config {
    always_on = true
    }
    app_settings = {
    DddsBatchTriggerTime           = "0 0/5 * * * *"
    FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
    mdiaikeyVaultName              = "MF-DM-CC-CORE-PREPROD-KV"
    mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
    WEBSITE_RUN_FROM_PACKAGE        = "1"
    APPINSIGHTS_INSTRUMENTATIONKEY   = azurerm_application_insights.MF-MDI-CC-AI-DDDS-AFUNC.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.MF-MDI-CC-AI-DDDS-AFUNC.connection_string
    mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "Vnet-Integration-DDDS-azfnc" {
  app_service_id = azurerm_function_app.MF-MDI-CC-DDDS-AFUNC.id
  subnet_id      = azurerm_subnet.MF_MDI_CC_AFUNC-SNET.id
  depends_on = [azurerm_function_app.MF-MDI-CC-DDDS-AFUNC]
}

resource "azurerm_function_app" "MF-MDI-CC-EXTERNALDATA-AFUNC" {
 name                       = "MF-DM-CC-PRE-PROD-EXTERNALDATA-AFUNC"
resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
    location            = azurerm_resource_group.MF_MDI_CC-RG.location
 app_service_plan_id        = azurerm_app_service_plan.MFDMCCASPAFUNC.id
 storage_account_name       = azurerm_storage_account.mfmdicccoresa.name
 storage_account_access_key = azurerm_storage_account.mfmdicccoresa.primary_access_key
 version                    = "~4"
 identity  {
        type                = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
    }
    site_config {
      always_on = true
      /*application_stack {
        dotnet_version = "8.0"
      }*/
    }
    app_settings = {
    DddsBatchTriggerTime           = "0 0/5 * * * *"
    FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
    mdiaikeyVaultName              = "MF-DM-CC-CORE-PREPROD-KV"
    mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
    WEBSITE_RUN_FROM_PACKAGE        = "1"
    WorkOrderStatusTriggerTime      = "0 0/15 * * * *"
    EquipmentStopTriggerTime        = "0 0/15 * * * *"
    SKUBatchTriggerTime             = "0 0/5 * * * *"
    APPINSIGHTS_INSTRUMENTATIONKEY   = azurerm_application_insights.MF-MDI-CC-AI-EXTERNALDATA-AFUNC.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.MF-MDI-CC-AI-EXTERNALDATA-AFUNC.connection_string
    mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "Vnet-Integration-externaldata-azfnc" {
  app_service_id = azurerm_function_app.MF-MDI-CC-EXTERNALDATA-AFUNC.id
  subnet_id      = azurerm_subnet.MF_MDI_CC_AFUNC-SNET.id
  depends_on = [azurerm_function_app.MF-MDI-CC-EXTERNALDATA-AFUNC]
}

resource "azurerm_function_app" "MF-MDI-CC-AUTO-SUBM-AFUNC" {
 name                       = "MF-DM-CC-PRE-PROD-AUTO-SUBM-AFUNC"
resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
    location            = azurerm_resource_group.MF_MDI_CC-RG.location
 app_service_plan_id        = azurerm_app_service_plan.MFDMCCASPAFUNC.id
 storage_account_name       = azurerm_storage_account.mfmdicccoresa.name
 storage_account_access_key = azurerm_storage_account.mfmdicccoresa.primary_access_key
 version                    = "~4"
 identity  {
        type                = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
    }
    site_config {
    always_on = true
    }
    app_settings = {
    DddsBatchTriggerTime           = "0 0/5 * * * *"
    AutoSubmitBatchTriggerTime     = "*/1 * * * *"
    FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
    mdiaikeyVaultName              = "MF-DM-CC-CORE-PREPROD-KV"
    mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
    WEBSITE_RUN_FROM_PACKAGE        = "1"
    APPINSIGHTS_INSTRUMENTATIONKEY   = azurerm_application_insights.MF-MDI-CC-AI-AUTO-SUBM-AFUNC.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.MF-MDI-CC-AI-AUTO-SUBM-AFUNC.connection_string
    mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "Vnet-Integration-auto-subm-azfnc" {
  app_service_id = azurerm_function_app.MF-MDI-CC-AUTO-SUBM-AFUNC.id
  subnet_id      = azurerm_subnet.MF_MDI_CC_AFUNC-SNET.id
  depends_on = [azurerm_function_app.MF-MDI-CC-AUTO-SUBM-AFUNC]
}

resource "azurerm_function_app" "MF-MDI-CC-LIVESKU-AFUNC" {
 name                       = "MF-MDI-PRE-PROD-CC-LIVESKU-AFUNC"
 resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
 location            = azurerm_resource_group.MF_MDI_CC-RG.location
 app_service_plan_id        = azurerm_app_service_plan.MFDMCCASPAFUNC.id
 storage_account_name       = azurerm_storage_account.mfmdicccoresa.name
 storage_account_access_key = azurerm_storage_account.mfmdicccoresa.primary_access_key
 version                    = "~4"

 identity  {
        type                = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.id]
    }

  site_config {
    always_on = true
    }

  app_settings = {
    AutoSubmitBatchTriggerTime     = "*/5 * * * *"
    FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
    mdiaikeyVaultName              = "MF-DM-CC-CORE-PREPROD-KV"
    mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
    WEBSITE_RUN_FROM_PACKAGE        = "1"
    mdiaiLiveSkuEVHConnectionString       = "@Microsoft.KeyVault(SecretUri=https://MF-DM-CC-CORE-PREPROD-KV.vault.azure.net/secrets/mdiaiLiveSkuEVHConnectionStringCDL/)"
    mdiaiLiveSkuEVHConsumerGrp            = "ehentity-skudata-stg2-cg1"
    mdiaiLiveSkuEVHName                   = "mf-mdi-cc-skudata-stg2"
    mdiaiLineStatusEVHConnectionString    = "@Microsoft.KeyVault(SecretUri=https://MF-DM-CC-CORE-PREPROD-KV.vault.azure.net/secrets/mdiaiLineStatusEVHConnectionStringCDL/)"
    mdiaiLineStatusEVHConsumerGrp         = "ehentity-linestatus-stg2-cg1"
    mdiaiLineStatusEVHName                = "mf-mdi-cc-linestatus-stg2"
    APPINSIGHTS_INSTRUMENTATIONKEY   = azurerm_application_insights.MF-MDI-CC-AI-LIVESKU-AFUNC.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.MF-MDI-CC-AI-LIVESKU-AFUNC.connection_string
    mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.client_id
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "Vnet-Integration-livesku-azfnc" {
  app_service_id = azurerm_function_app.MF-MDI-CC-LIVESKU-AFUNC.id
  subnet_id      = azurerm_subnet.MF_MDI_CC_AFUNC-SNET.id
  depends_on = [azurerm_function_app.MF-MDI-CC-LIVESKU-AFUNC]
}

# resource "azurerm_function_app" "MF-MDI-CC-PROD-SENSORDATA-WRITE-AFUNC" {
#   provider            = azurerm.MF-MDI-Prod-Subscription
#  name                       = "MF-MDI-CC-PROD-SENSORDATA-WRITE-AFUNC"
#  resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
#  location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
#  app_service_plan_id        = azurerm_app_service_plan.MFMDICCPRODASPAFUNC.id
#  storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
#  storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
#  version                    = "~4"

#     identity  {
#         type                = "SystemAssigned, UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
#     }

#     site_config {
#     always_on = true
#     }

#   app_settings = {
#     AutoSubmitBatchTriggerTime     = "*/5 * * * *"
#     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
#     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
#     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
#     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
#     WEBSITE_RUN_FROM_PACKAGE        = "1"
#     mdiaiSensorDataEVHConnectionString   = "@Microsoft.KeyVault(SecretUri=https://MF-MDI-CORE-PROD-KV.vault.azure.net/secrets/mdiaiSensorDataEVHConnectionStringCDL/)"
#     mdiaiSensorDataEVHConsumerGrp         = "ehentity-stg2-cg1"
#     mdiaiSensorDataEVHName                = "mf-mdi-cc-prod-ehentity-stg2"
#     APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.MF-MDI-CC-PROD-AI-SENSORDATA-AFUNC.instrumentation_key
#     APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.MF-MDI-CC-PROD-AI-SENSORDATA-AFUNC.connection_string
#     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
#   }
# }

# resource "azurerm_app_service_virtual_network_swift_connection" "Vnet-Integration-sensordata-azfnc" {
#   provider            = azurerm.MF-MDI-Prod-Subscription
#   app_service_id = azurerm_function_app.MF-MDI-CC-PROD-SENSORDATA-WRITE-AFUNC.id
#   subnet_id      = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id
#   depends_on = [azurerm_function_app.MF-MDI-CC-PROD-SENSORDATA-WRITE-AFUNC]
# }
# /*

# #removing linestatus function app

# resource "azurerm_function_app" "MF-MDI-CC-PROD-LINESTATUS-WRITE-AFUNC" {
#   provider            = azurerm.MF-MDI-Prod-Subscription
#  name                       = "MF-MDI-CC-PROD-LINESTATUS-WRITE-AFUNC"
#  resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
#  location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
#  app_service_plan_id        = azurerm_app_service_plan.MFMDICCPRODASPAFUNC.id
#  storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
#  storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
#  version                    = "~4"

#     identity  {
#         type                = "SystemAssigned"
#     }

#     site_config {
#     always_on = true
#     }

#   app_settings = {

#     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
#     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
#     mdiaiadappClientId             = "2f3c2140-f86d-4018-bc19-8750c8bc8817"
#     mdiaiadappClientSecret         = "8B.8Q~m_4UhrQaPiZyr~WtcQMcG9aIHWYq.gecrT"
#     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
#     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
#     WEBSITE_RUN_FROM_PACKAGE        = "1"
#     mdiaiLineStatusEVHConnectionString    = "@Microsoft.KeyVault(SecretUri=https://MF-MDI-CORE-PROD-KV.vault.azure.net/secrets/mdiaiLineStatusEVHConnectionStringCDL/)"
#     mdiaiLineStatusEVHConsumerGrp         = "ehentity-linestatus-stg2-cg1"
#     mdiaiLineStatusEVHName                = "mf-mdi-cc-prod-linestatus-stg2"
#     APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.MF-MDI-CC-PROD-AI-LINESTATUS-AFUNC.instrumentation_key
#     APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.MF-MDI-CC-PROD-AI-LINESTATUS-AFUNC.connection_string
#   }
# }

# resource "azurerm_app_service_virtual_network_swift_connection" "Vnet-Integration-linestatus-azfnc" {
#   provider            = azurerm.MF-MDI-Prod-Subscription
#   app_service_id = azurerm_function_app.MF-MDI-CC-PROD-LINESTATUS-WRITE-AFUNC.id
#   subnet_id      = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id
#   depends_on = [azurerm_function_app.MF-MDI-CC-PROD-LINESTATUS-WRITE-AFUNC]
# }*/
# # ###################### Data Archive Function App ###########################################
# # resource "azurerm_service_plan" "mfmdiccprodspafunc" {
# #   provider            = azurerm.MF-MDI-Prod-Subscription
# #  name                = "MF-MDI-CC-PROD-SP-AFUNC"
# #  resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #  location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #  os_type             = "Linux"
# #  sku_name            = "P2v2"
# # }

# # resource "azurerm_linux_function_app" "MF-MDI-CC-PROD-DATAARCHIVESERVICE-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-PROD-DATAARCHIVESERVICE-AFUNC"
# #  resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #  location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #  service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #  storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #  storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #  virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-DATAARCHIVESERVCIE-AFUNC.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-DATAARCHIVESERVCIE-AFUNC.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiadappClientId             = "2f3c2140-f86d-4018-bc19-8750c8bc8817"
# #     mdiaiadappClientSecret         = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiadappClientSecret/)"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     BlobStorageContainerName        = "mdi-data-archive"
# #     mdiaiBlobStorageConnectionString    = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiAzureStorageConnectionString/)"
# #     RootPath                    = "MDIxAI/Data/Archive/SensorData/"
# #     RootPathProcessedData       = "MDIxAI/Data/Archive/ProcessedData/"
# #     Source                      = "Sensor,SKU,LINESTATUS"
# #     partitionId                 = "0,1,2,3"
# #     plantCodes                  = "CDL"
# #     mdiaiDataArchiveEVHName             = "mf-mdi-cc-prod-ehentity-alldata"
# #     mdiaiDataArchiveEVHConsumerGrp      = "mf-mdi-cc-prod-ehentity-alldata_cg-da"
# #     mdiaiDataArchiveEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiDataArchiveEVHConnectionString/)"
# #     mdiaiDataArchiveEVHNameCdl             = "mf-mdi-cc-prod-ehentity-stg2"
# #     mdiaiDataArchiveEVHConsumerGrpCdl      = "ehentity-stg2-cg-dataarchive"
# #     mdiaiDataArchiveEVHConnectionStringCdl = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiDataArchiveEVHConnectionStringCdl/)"
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id


# #   }
# # }

# # ######################## Florenceville Function apps ######################################################
# # resource "azurerm_linux_function_app" "MF-MDI-CC-FVL-PROD-SENSORDATA-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-FVL-PROD-SENSORDATA-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-FVL.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-FVL.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiSensorDataEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiSensorDataEVHConnectionStringFVL/)"
# #     mdiaiSensorDataEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-fvl-stg2-cg1.name
# #     mdiaiSensorDataEVHName             = azurerm_eventhub.mf-mdi-cc-prod-ehentity-stg2-florenceville.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }

# # resource "azurerm_linux_function_app" "MF-MDI-CC-FVL-PROD-LIVESKU-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-FVL-PROD-LIVESKU-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-FVL.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-FVL.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiLiveSkuEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLiveSkuEVHConnectionStringFVL/)"
# #     mdiaiLiveSkuEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-fvl-skudata-stg2-cg1.name
# #     mdiaiLiveSkuEVHName             = azurerm_eventhub.mf-mdi-cc-prod-skudata-stg2-florenceville.name
# #     mdiaiLineStatusEVHConnectionString    = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLineStatusEVHConnectionStringFVL/)"
# #     mdiaiLineStatusEVHConsumerGrp         = azurerm_eventhub_consumer_group.ehentity-fvl-linestatus-stg2-cg1.name
# #     mdiaiLineStatusEVHName                = azurerm_eventhub.mf-mdi-cc-prod-linestatus-stg2-florenceville.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }

# # ######################## Matougue Function apps ######################################################
# # resource "azurerm_linux_function_app" "MF-MDI-CC-MAT-PROD-SENSORDATA-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-MAT-PROD-SENSORDATA-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-MAT.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-MAT.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiSensorDataEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiSensorDataEVHConnectionStringMAT/)"
# #     mdiaiSensorDataEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-stg2-mat-cg1.name
# #     mdiaiSensorDataEVHName             = azurerm_eventhub.mf-mdi-cc-prod-ehentity-stg2-matougues.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }

# # resource "azurerm_linux_function_app" "MF-MDI-CC-MAT-PROD-LIVESKU-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-MAT-PROD-LIVESKU-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-MAT.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-MAT.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiLiveSkuEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLiveSkuEVHConnectionStringMAT/)"
# #     mdiaiLiveSkuEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-skudata-mat-stg2-cg1.name
# #     mdiaiLiveSkuEVHName             = azurerm_eventhub.mf-mdi-cc-prod-skudata-stg2-matougues.name
# #     mdiaiLineStatusEVHConnectionString    = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLineStatusEVHConnectionStringMAT/)"
# #     mdiaiLineStatusEVHConsumerGrp         = azurerm_eventhub_consumer_group.ehentity-linestatus-stg2-cg1-mat.name
# #     mdiaiLineStatusEVHName                = azurerm_eventhub.mf-mdi-cc-prod-linestatus-stg2-matougues.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }

# # ######################## Burley Function apps ######################################################
# # resource "azurerm_linux_function_app" "MF-MDI-CC-BUR-PROD-SENSORDATA-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-BUR-PROD-SENSORDATA-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-BUR.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-BUR.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiSensorDataEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiSensorDataEVHConnectionStringBUR/)"
# #     mdiaiSensorDataEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-bur-stg2-cg1.name
# #     mdiaiSensorDataEVHName             = azurerm_eventhub.mf-mdi-cc-prod-ehentity-stg2-burley.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }

# # resource "azurerm_linux_function_app" "MF-MDI-CC-BUR-PROD-LIVESKU-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-BUR-PROD-LIVESKU-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-BUR.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-BUR.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiLiveSkuEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLiveSkuEVHConnectionStringBUR/)"
# #     mdiaiLiveSkuEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-bur-skudata-stg2-cg1.name
# #     mdiaiLiveSkuEVHName             = azurerm_eventhub.mf-mdi-cc-prod-skudata-stg2.name
# #     mdiaiLineStatusEVHConnectionString    = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLineStatusEVHConnectionStringBUR/)"
# #     mdiaiLineStatusEVHConsumerGrp         = azurerm_eventhub_consumer_group.ehentity-bur-linestatus-stg2-cg1.name
# #     mdiaiLineStatusEVHName                = azurerm_eventhub.mf-mdi-cc-prod-linestatus-stg2-burley.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }

# # ######################## Harnes Function apps ######################################################
# # resource "azurerm_linux_function_app" "MF-MDI-CC-HAR-PROD-SENSORDATA-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-HAR-PROD-SENSORDATA-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-HAR.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-SENSORDATA-AFUNC-HAR.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiSensorDataEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiSensorDataEVHConnectionStringHAR/)"
# #     mdiaiSensorDataEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-har-stg2-cg1.name
# #     mdiaiSensorDataEVHName             = azurerm_eventhub.mf-mdi-cc-prod-ehentity-stg2-harnes.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }

# # resource "azurerm_linux_function_app" "MF-MDI-CC-HAR-PROD-LIVESKU-AFUNC" {
# #    provider            = azurerm.MF-MDI-Prod-Subscription
# #   name                = "MF-MDI-CC-HAR-PROD-LIVESKU-AFUNC"
# #   resource_group_name = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.name
# #   location            = azurerm_resource_group.MF_MDI_CC_PROD_CORE-RG.location
# #   service_plan_id        = azurerm_service_plan.mfmdiccprodspafunc.id
# #   storage_account_name       = azurerm_storage_account.mfmdiccprodcoresa.name
# #   storage_account_access_key = azurerm_storage_account.mfmdiccprodcoresa.primary_access_key
# #   virtual_network_subnet_id   = azurerm_subnet.MF_MDI_CC_PROD_AFUNC-SNET.id

# #   site_config {
# #     always_on                 = true
# #     application_insights_connection_string = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-HAR.connection_string
# #     application_insights_key  = azurerm_application_insights.MF-MDI-CC-PROD-LIVESKU-AFUNC-HAR.instrumentation_key
# #     application_stack{
# #        dotnet_version            = "8.0"
# #        use_dotnet_isolated_runtime = true
# #     }
# #   }
# #   identity  {
# #      type                = "SystemAssigned, UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.id]
# #   }

# #  app_settings = {
# #     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
# #     mdiaikeyVaultName              = "MF-MDI-CORE-PROD-KV"
# #     mdiaiTenantId                  = "59fa7797-abec-4505-81e6-8ce092642190"
# #     WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
# #     WEBSITE_RUN_FROM_PACKAGE        = "1"
# #     mdiaiLiveSkuEVHConnectionString = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLiveSkuEVHConnectionStringHAR/)"
# #     mdiaiLiveSkuEVHConsumerGrp      = azurerm_eventhub_consumer_group.ehentity-har-skudata-stg2-cg1.name
# #     mdiaiLiveSkuEVHName             = azurerm_eventhub.mf-mdi-cc-prod-skudata-stg2.name
# #     mdiaiLineStatusEVHConnectionString    = "@Microsoft.KeyVault(SecretUri=https://mf-mdi-core-prod-kv.vault.azure.net/secrets/mdiaiLineStatusEVHConnectionStringHAR/)"
# #     mdiaiLineStatusEVHConsumerGrp         = azurerm_eventhub_consumer_group.ehentity-har-linestatus-stg2-cg1.name
# #     mdiaiLineStatusEVHName                = azurerm_eventhub.mf-mdi-cc-prod-linestatus-stg2-harnes.name
# #     mdiaiUserAssignedMIClientID     = azurerm_user_assigned_identity.MF_MDI_CC_CORE_PROD_APP_ACCESS-USER-IDENTITY.client_id
# #   }
# # }
