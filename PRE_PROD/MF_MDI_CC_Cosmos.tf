
resource "azurerm_cosmosdb_account" "mf-mdi-cc-cosmosdb" {
  name                                  = var.mf-dm-cc-cosmosdb_Name
  location                              = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.location
  resource_group_name                   = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  offer_type                            = "Standard"
  kind                                  = "GlobalDocumentDB"
  analytical_storage_enabled            = true
  network_acl_bypass_for_azure_services = true
  network_acl_bypass_ids                = ["/subscriptions/6b5fafad-c388-4834-8e16-daf9828deb84/resourceGroups/MF_GDA_Synapse_PRE_PROD-RG/providers/Microsoft.Synapse/workspaces/azure-synapse-workspace-01-pre_prod"]
  ip_range_filter                       = ["198.164.100.100", "136.226.77.100", "136.226.77.77", "165.225.209.36", "165.225.209.75", "136.226.77.110", "165.225.209.57", "165.225.209.34"]
  consistency_policy {
    consistency_level = "Session"
  }

  backup {
    type = "Continuous"
    tier = "Continuous7Days"
  }

  geo_location {
    location          = "Canada Central"
    failover_priority = 0
    zone_redundant    = false
  }

  /*geo_location {
    location          = "Canada East"
    failover_priority = 1
  }*/
}


resource "azurerm_cosmosdb_sql_database" "MDIxAI_PRE_PROD" {

  name                = "MDIxAI_TRAIN"
  resource_group_name = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name        = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "ActionItems" {

  name                   = "ActionItems"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000



  autoscale_settings {
    max_throughput = 2000
  }

}

resource "azurerm_cosmosdb_sql_container" "DDDSMeeting" {

  name                   = "DDDSMeeting"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}
resource "azurerm_cosmosdb_sql_container" "Defects" {

  name                   = "Defects"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 4000
  }
}
resource "azurerm_cosmosdb_sql_container" "HandoffResponses" {

  name                   = "HandoffResponses"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "HandoffTemplates" {

  name                   = "HandoffTemplates"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = -1
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "HandOffPCLReports" {

  name                   = "HandOffPCLReports"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "ActionLogs" {

  name                   = "ActionLogs"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "PlantData" {

  name                   = "PlantData"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 5184000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}
#
resource "azurerm_cosmosdb_sql_container" "PlannedOrders" {

  name                   = "PlannedOrders"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "LiveSkuHistory" {

  name                   = "LiveSkuHistory"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "LiveSkuLatest" {

  name                   = "LiveSkuLatest"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "SensorDataLatest" {

  name                   = "SensorDataLatest"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "BinrawData" {

  name                   = "BinrawData"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 5184000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "LineStatusHistory" {

  name                   = "LineStatusHistory"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "EquipmentStops" {

  name                   = "EquipmentStops"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "RecapResponse" {

  name                   = "RecapResponse"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
  partition_key_paths    = ["/pkey"]
  partition_key_version  = 1
  default_ttl            = 7776000
  analytical_storage_ttl = 31536000

  autoscale_settings {
    max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "TasksComments" {
 name                = "TasksComments"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
 partition_key_paths    = ["/pkey"]
 default_ttl = 31536000
 analytical_storage_ttl = 31536000
autoscale_settings  {
          max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "Tasks" {
 name                = "Tasks"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
 partition_key_paths    = ["/pkey"]
 default_ttl = -1
 analytical_storage_ttl = 31536000
autoscale_settings  {
          max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "Routes" {
 name                = "Routes"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
 partition_key_paths    = ["/pkey"]
 default_ttl = -1
 analytical_storage_ttl = 31536000
autoscale_settings  {
          max_throughput = 2000
  }
}

resource "azurerm_cosmosdb_sql_container" "RouteProcess" {
 name                = "RouteProcess"
  resource_group_name    = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  account_name           = azurerm_cosmosdb_account.mf-mdi-cc-cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.MDIxAI_PRE_PROD.name
 partition_key_paths    = ["/pkey"]
 default_ttl = 31536000
 analytical_storage_ttl = 31536000
 #default_ttl = 31536000
autoscale_settings  {
          max_throughput = 2000
  }
}
