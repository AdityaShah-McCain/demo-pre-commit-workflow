data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "MF_MDI_CC_CORE-KEY-VAULT" {
  name                            = var.cc_core_key_vault
  location                        = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name             = azurerm_resource_group.MF_MDI_CC-RG.name
  enabled_for_disk_encryption     = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  enabled_for_template_deployment = true
  sku_name                        = var.cc_core_key_vault_sku
  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = data.azurerm_client_config.current.object_id

  #   key_permissions = [
  #     "Get",
  #   ]

  #   secret_permissions = [
  #     "Get",
  #   ]

  #   storage_permissions = [
  #     "Get",
  #   ]
  #   certificate_permissions = [
  #     "Get",
  #   ]
  # }
}
# resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_TF_KEY_VAULT_ACCESS_POLICY" {

#   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
#   tenant_id    = var.MF_tenant_id
#   object_id = data.azurerm_client_config.current.object_id

#   key_permissions = [
#     "Get", "List"
#   ]

#   secret_permissions = [
#     "Get", "List"
#   ]

#     storage_permissions = [
#       "Get",
#     ]
#   certificate_permissions = [
#     "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
#   ]

#   depends_on = [
#     azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
#   ]
#   lifecycle {
#     prevent_destroy = true
#   }
# }

resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_AUTH_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_AUTH_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE.identity[0].principal_id
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_DDH_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-ddh.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_DDH_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-ddh.identity[0].principal_id
  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY.principal_id
  certificate_permissions = [
    "Get", "List" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_role_assignment" "MF_MDI_CC_CORE_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY.principal_id
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_DDDS_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-DDDS.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]

}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_DDDS_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-DDDS.identity[0].principal_id

}


resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_dcl_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-dcl.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_dcl_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-dcl.identity[0].principal_id
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_cid_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-cid.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}
###############################################################################################################
###############################################################################################################
# resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_cid_KEY_VAULT_ROLE_ASSGN" {

#   scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
#   role_definition_name = "Key Vault Administrator"
#   principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-cid.identity[0].principal_id
#   lifecycle {
#     prevent_destroy = true
#   }
# }
# # # # data "azurerm_key_vault_secret" "MF_MDI_CC_KV_mdiaiClientId" {
# # # #   name         = "mdiaiClientId"
# # # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # # }

# # # # data "azurerm_key_vault_secret" "MF_MDI_CC_KV_mdiaiClientSecret" {
# # # #   name         = "mdiaiClientSecret"
# # # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # # }

# # # # data "azurerm_key_vault_secret" "MF_MDI_CC_KV_mdiaiTenantId" {
# # # #   name         = "mdiaiTenantId"
# # # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # # }

# # /*resource "azurerm_key_vault_secret" "mdiaiStorageAccountName" {
# #   name         = "mdiaiStorageAccountName"
# #   value        = "mfmdicccoredevsa"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiAzureStorageAccountKey" {
# #   name         = "mdiaiAzureStorageAccountKey"
# #   value        = "vfmtzf4dit4BFVdeW8S+pv5h8UB+W8wMA7tVl9VPlNu3/UZiM/sQFFh4WhbTheWww+5SRFyj+Vmp+AStoi1I/g=="
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiAzureStorageConnectionString" {
# #   name         = "mdiaiAzureStorageConnectionString"
# #   value        = "DefaultEndpointsProtocol=https;AccountName=mfmdicccoredevsa;AccountKey=vfmtzf4dit4BFVdeW8S+pv5h8UB+W8wMA7tVl9VPlNu3/UZiM/sQFFh4WhbTheWww+5SRFyj+Vmp+AStoi1I/g==;EndpointSuffix=core.windows.net"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }*/

# # /*resource "azurerm_key_vault_secret" "mdiaiCosmosConnectionString" {
# #   name         = "mdiaiCosmosConnectionString"
# #   value        = "AccountEndpoint=https://mf-mdi-cc-dev-cosmosdbdev.documents.azure.com:443/;AccountKey=lD8XeA58v3jKa0gJOTQXvtCURTeU2a47tkp0cqtSvBsyKcGYsAIcYRGtq8Uf1oSpv2FWcGG4QxWmACDbthbB6Q==;"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }


# # resource "azurerm_key_vault_secret" "mdiaiCosmosDBName" {
# #   name         = "mdiaiCosmosDBName"
# #   value        = "MDIxAI_DEV"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }*/
# # /*
# # resource "azurerm_key_vault_secret" "mdiaiIssuer" {
# #   name         = "mdiaiIssuer"
# #   value        = "https://sts.windows.net/59fa7797-abec-4505-81e6-8ce092642190/"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiIssuerSigningSecretKey" {
# #   name         = "mdiaiIssuerSigningSecretKey"
# #   value        = "J8Y#k12$1PQs9!5BJ8Y#k12$1PQs9!5BJ8Y#k12$1PQs9!5B"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiSqlConnectionString" {
# #   name         = "mdiaiSqlConnectionString"
# #   value        = var.cc_core_sql_cs
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiBinRawConnectionString" {
# #   name         = "mdiaiBinRawConnectionString"
# #   value        = "Server=tcp:mf-ag-digital-core-infrastructure-dev2-sql.c5520a5d36ad.database.windows.net,1433;Database=mf-dag-core-saturndev-sql-db;"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }


# # resource "azurerm_key_vault_secret" "mdicontainerrootpathdefect" {
# #   name         = "mdicontainerrootpathdefect"
# #   value        = "mdiaiddh"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdicontainerrootpathcid" {
# #   name         = "mdicontainerrootpathcid"
# #   value        = "mdiaicid"
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }*/
# # /*resource "azurerm_key_vault_secret" "mdiaiCBMDataServiceEVHConnectionString" {
# #   name         = "mdiaiCBMDataServiceEVHConnectionString"
# #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-Coaldaledat_policy.primary_connection_string
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }*/
# # ################################### Matougue EH CS ##########################################
# # /*resource "azurerm_key_vault_secret" "mdiaiSensorDataEVHConnectionStringMAT" {
# #   name         = "mdiaiSensorDataEVHConnectionStringMAT"
# #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-MAT-Output_policy.primary_connection_string
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiLiveSkuEVHConnectionStringMAT" {
# #   name         = "mdiaiLiveSkuEVHConnectionStringMAT"
# #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-MAT-skudata-Output_policy.primary_connection_string
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiLineStatusEVHConnectionStringMAT" {
# #   name         = "mdiaiLineStatusEVHConnectionStringMAT"
# #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-MAT-linestatus-Output_policy.primary_connection_string
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }*/
# # ################################### Florenceville EH CS ##########################################
# # /*resource "azurerm_key_vault_secret" "mdiaiSensorDataEVHConnectionStringFVL" {
# #   name         = "mdiaiSensorDataEVHConnectionStringFVL"
# #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-FVL-Output_policy.primary_connection_string
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiLiveSkuEVHConnectionStringFVL" {
# #   name         = "mdiaiLiveSkuEVHConnectionStringFVL"
# #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-FVL-skudata-Output_policy.primary_connection_string
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }

# # resource "azurerm_key_vault_secret" "mdiaiLineStatusEVHConnectionStringFVL" {
# #   name         = "mdiaiLineStatusEVHConnectionStringFVL"
# #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-FVL-linestatus-Output_policy.primary_connection_string
# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # }*/

# # # ################################### Burley EH CS ##########################################
# # # /*resource "azurerm_key_vault_secret" "mdiaiSensorDataEVHConnectionStringBUR" {
# # #   name         = "mdiaiSensorDataEVHConnectionStringBUR"
# # #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-BUR-Output_policy.primary_connection_string
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # }*/

# # # resource "azurerm_key_vault_secret" "mdiaiLiveSkuEVHConnectionStringBUR" {
# # #   name         = "mdiaiLiveSkuEVHConnectionStringBUR"
# # #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-BUR-skudata-function-Output_policy.primary_connection_string
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # }

# # # /*resource "azurerm_key_vault_secret" "mdiaiLineStatusEVHConnectionStringBUR" {
# # #   name         = "mdiaiLineStatusEVHConnectionStringBUR"
# # #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-BUR-linestatus-Output_policy.primary_connection_string
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # }*/

# # # ################################### Harnes EH CS ##########################################
# # # /*resource "azurerm_key_vault_secret" "mdiaiSensorDataEVHConnectionStringHAR" {
# # #   name         = "mdiaiSensorDataEVHConnectionStringHAR"
# # #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-HAR-Output_policy.primary_connection_string
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # }*/

# # # resource "azurerm_key_vault_secret" "mdiaiLiveSkuEVHConnectionStringHAR" {
# # #   name         = "mdiaiLiveSkuEVHConnectionStringHAR"
# # #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-HAR-skudata-function-Output_policy.primary_connection_string
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # }

# # # /*resource "azurerm_key_vault_secret" "mdiaiLineStatusEVHConnectionStringHAR" {
# # #   name         = "mdiaiLineStatusEVHConnectionStringHAR"
# # #   value        = azurerm_eventhub_authorization_rule.MF-MDI-CC-DEV-STG2-ASA-HAR-linestatus-Output_policy.primary_connection_string
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # # }*/
# # # #############################################################################################

# # /*resource "azurerm_key_vault_access_policy" "TERRAFORM_USER_KV_ACCESS_POLICY" {

# #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# #   tenant_id    = var.MF_tenant_id
# #   object_id    = data.azurerm_client_config.current.object_id
# #   certificate_permissions = [
# #     "Get", "List", "Create", "Update", "Delete", "GetIssuers", "Import", "ListIssuers", "SetIssuers", "ManageIssuers", "ManageContacts"
# #   ]
# #   secret_permissions = [
# #     "Set", "Get", "Delete", "Purge", "Recover", "List"
# #   ]
# #   key_permissions = [
# #     "Get", "List", "Import", "Create", "Update", "Delete", "Recover"
# #   ]
# #   depends_on = [
# #     azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT
# #   ]
# #   lifecycle {
# #     prevent_destroy = false
# #   }
# # }*/



# # # #KeyVault Access Policy for FunctionApps
# # # ########################################
# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_SENSOR_DATA_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_function_app.MF-MDI-CC-DEV-SENSORDATA-WRITE-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_LINE_STATUS_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_function_app.MF-MDI-CC-DEV-LINESTATUS-WRITE-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_LIVE_SKU_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_function_app.MF-MDI-CC-DEV-LIVESKU-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_CBMSERVICE_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-DEV-CBMSERVICE-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-DEV-CBMSERVICE-AFUNC]
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_DATAARCHIVE_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-DEV-DATAARCHIVESERVICE-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-DEV-DATAARCHIVESERVICE-AFUNC]
# # # }

# # # ########################################### Matougues KV Access Policy ###############################
# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_MAT_SENSOR_DATA_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-MAT-DEV-SENSORDATA-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-MAT-DEV-SENSORDATA-AFUNC]
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_MAT_LIVESKU_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-MAT-DEV-LIVESKU-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-MAT-DEV-LIVESKU-AFUNC]
# # # }

# # # /*resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_MAT_LINESTATUS_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-MAT-DEV-LINESTATUS-WRITE-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-MAT-DEV-LINESTATUS-WRITE-AFUNC]
# # # }*/
# # # ########################################### Florenceville KV Access Policy ###############################
# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_FVL_SENSOR_DATA_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-FVL-DEV-SENSORDATA-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-FVL-DEV-SENSORDATA-AFUNC]
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_FVL_LIVESKU_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-FVL-DEV-LIVESKU-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-FVL-DEV-LIVESKU-AFUNC]
# # # }

# # # ########################################### Burley KV Access Policy ###############################
# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_BUR_SENSOR_DATA_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-BUR-DEV-SENSORDATA-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-BUR-DEV-SENSORDATA-AFUNC]
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_BUR_LIVESKU_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-BUR-DEV-LIVESKU-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-BUR-DEV-LIVESKU-AFUNC]
# # # }


# # ########################################### Harnes KV Access Policy ###############################
# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_HAR_SENSOR_DATA_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-HAR-DEV-SENSORDATA-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-HAR-DEV-SENSORDATA-AFUNC]
# # # }

# # # resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_HAR_LIVESKU_AFUNC_KEY_VAULT_ACCESS_POLICY" {
# # #
# # #   key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
# # #   tenant_id    = var.MF_tenant_id
# # #   object_id    = azurerm_linux_function_app.MF-MDI-CC-HAR-DEV-LIVESKU-AFUNC.identity[0].principal_id
# # #   certificate_permissions = [
# # #     "Get", "List", "GetIssuers", "ListIssuers"
# # #   ]
# # #   secret_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   key_permissions = [
# # #     "Get", "List"
# # #   ]
# # #   lifecycle {
# # #     prevent_destroy = true
# # #   }
# # #   depends_on = [azurerm_linux_function_app.MF-MDI-CC-HAR-DEV-LIVESKU-AFUNC]
# # # }
