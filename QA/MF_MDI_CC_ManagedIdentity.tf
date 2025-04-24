############################
# USER MANAGED IDENTITY
############################

resource "azurerm_user_assigned_identity" "MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY" {
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  name                = "MF_CC_CORE_QA_APP_ACCESS-USER-IDENTITY"
  lifecycle {
    prevent_destroy   = true
  }
  tags                = local.tag_list_1
}

#Cosmos DB Custom Role
resource "azurerm_cosmosdb_sql_role_definition" "CosmosDB-DataContributor" {
  resource_group_name = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name        = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  name                = "Cosmos DB Data Contributor Role"
  assignable_scopes   = [azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.id]


  permissions {
    data_actions = [
      "Microsoft.DocumentDB/databaseAccounts/readMetadata",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*"
      ]
  }

}

#Cosmos DB Custom Role Assignment to UMI

resource "azurerm_cosmosdb_sql_role_assignment" "CosmosDB-UserMangedIdentity-Role-Assignment" {
  resource_group_name                   = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  role_definition_id  = azurerm_cosmosdb_sql_role_definition.CosmosDB-DataContributor.id
  scope               = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.id
  account_name        = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  principal_id        = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APP_ACCESS-USER-IDENTITY.principal_id
}
