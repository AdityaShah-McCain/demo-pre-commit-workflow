#############################################################################
#                       Private Endpoint
#############################################################################
# ============ Cosmos DB ==========================

data "azurerm_resources" "MF_MDI_CC_STORAGE-RG" {
  name = "MF_MDI_CC_STORAGE-RG"
}
data "azurerm_cosmosdb_account" "mf-mdi-cc-cosmosdb" {
  name                = var.mf-dm-cc-cosmosdb_Name
  resource_group_name = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
}
resource "azurerm_private_endpoint" "MF_MDI_CC-COSMOSDB-PEP" {

  name                = "${data.azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name}-PEP"
  location            = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.location
  resource_group_name = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  subnet_id           = azurerm_subnet.MF_MDI_CC_PLINK-SNET.id
  tags                = local.tag_list_1

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.PRIVATE_DNS_ZONES["privatelink-documents-azure-com"].id]
  }

  private_service_connection {
    name = "${data.azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name}-PSC"
    # private_connection_resource_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_resources.MF_MDI_CC_STORAGE-RG.name}/providers/Microsoft.DocumentDB/databaseAccounts/${data.azurerm_cosmosdb_account.mf-dm-cc-cosmosdb.name}"
    private_connection_resource_id = "/subscriptions/5d225f46-3a3f-4729-a5ec-dffd77831244/resourceGroups/MF_DM_CC_STORAGE-PRE_PROD-RG/providers/Microsoft.DocumentDB/databaseAccounts/mf-dm-cc-preprod-cosmosdbpreprod"
    is_manual_connection           = false
    subresource_names              = ["sql"]
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}
