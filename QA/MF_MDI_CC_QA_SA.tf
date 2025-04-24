# # Naming of resources need to be modified as per McCain Standards.

# #############################################################################
# #                       Azure storage account
# #############################################################################

resource "azurerm_storage_account" "mfmdicccoresa" {

  name                     = var.mf_dm_cc_sa_name
  resource_group_name      = azurerm_resource_group.MF_MDI_CC-RG.name
  location                 = azurerm_resource_group.MF_MDI_CC-RG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tag_list_1

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "mdixai" {

  name                  = "mdixai"
  storage_account_name  = azurerm_storage_account.mfmdicccoresa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "mdiaicid" {

  name                  = "mdiaicid"
  storage_account_name  = azurerm_storage_account.mfmdicccoresa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "mdiaiddh" {

  name                  = "mdiaiddh"
  storage_account_name   = azurerm_storage_account.mfmdicccoresa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "mdixai-cbm" {

  name                  = "mdixai-cbm"
  storage_account_name  = azurerm_storage_account.mfmdicccoresa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "mdi-data-archive" {

  name                  = "mdi-data-archive"
  storage_account_name  = azurerm_storage_account.mfmdicccoresa.name
  container_access_type = "private"
}

data "azurerm_role_definition" "storageblob-contributor" {

  name = "Storage Blob Data Contributor"
}

resource "azurerm_role_assignment" "STORAGEACCOUNT-ACARollassignment" {

  scope              = azurerm_storage_account.mfmdicccoresa.id
  role_definition_id = data.azurerm_role_definition.storageblob-contributor.id
  principal_id       = azurerm_container_app.MF_MDI_CC-CAPP-DDDS.identity[0].principal_id
}

resource "azurerm_role_assignment" "STORAGEACCOUNT-ACACIDRoleassignment" {

  scope              = azurerm_storage_account.mfmdicccoresa.id
  role_definition_id = data.azurerm_role_definition.storageblob-contributor.id
  principal_id       = azurerm_container_app.MF_MDI_CC-CAPP-cid.identity[0].principal_id
}

resource "azurerm_role_assignment" "STORAGEACCOUNT-webappRoleassignment" {

  scope              = azurerm_storage_account.mfmdicccoresa.id
  role_definition_id = data.azurerm_role_definition.storageblob-contributor.id
  principal_id       = azurerm_windows_web_app.MF-MDI-CC-CORE-Webapp.identity[0].principal_id
}

resource "azurerm_role_assignment" "STORAGEACCOUNT-DDHACARoleassignment" {

  scope              = azurerm_storage_account.mfmdicccoresa.id
  role_definition_id = data.azurerm_role_definition.storageblob-contributor.id
  principal_id       = azurerm_container_app.MF_MDI_CC-CAPP-ddh.identity[0].principal_id
}
