# #############################################################################
# #                       Azure SQL Managed Instance
# #############################################################################

resource "azurerm_mssql_managed_instance" "MF_MDI_CC_CORESQLMI" {
  name                         = "mf-dm-qa-sqlmi"
  resource_group_name          = azurerm_resource_group.MF_MDI_CC-RG.name
  location                     = azurerm_resource_group.MF_MDI_CC-RG.location
  administrator_login          = "sqlmiqaadmin"
  administrator_login_password = "Sql@MI2024Mcn"
  license_type                 = "LicenseIncluded"
#   subnet_id                    = "/subscriptions/855f9502-3230-4377-82a2-cc5c8fa3c59d/resourceGroups/MF_MDIxMI_Github_DEV_RG/providers/Microsoft.Network/virtualNetworks/MF_MDI_CC_DEV_CORE-VNET/subnets/MF_MDI_CC_DEV_SQLMI-SNET"
  subnet_id                    = azurerm_subnet.MF_MDI_CC_SQLMI-SNET.id
  sku_name                     = "GP_Gen5"
  vcores                       = 4
  storage_size_in_gb           = 32

  identity {
    type = "SystemAssigned"
  }
  #public_network_access_enabled {
  #public_network_access_enabled = true
  #}
  # lifecycle {
  #   prevent_destroy = true
  # }

 }
# #Managed mssql backup database
# #############################################################################
# /*resource "azurerm_mssql_managed_database" "MDIxAI_DEV_BKP2" {
#    provider            = azurerm.MF-MDISubscription
#   name                = "MDIxAI_DEV_BKP2"
#   managed_instance_id = azurerm_mssql_managed_instance.MF_MDI_CC_CORESQLMI.id

#   point_in_time_restore {
#     restore_point_in_time = "2024-07-05T12:01:31Z"
#     source_database_id    = "/subscriptions/5d225f46-3a3f-4729-a5ec-dffd77831244/resourceGroups/MF_MDI_CC-RG/providers/Microsoft.Sql/managedInstances/mf-mdi-cc-coresqlmi/databases/MDIxAI_DEV"
#   }

#   # prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = true
#   }
# }*/

# # resource "azurerm_mssql_managed_database" "MDIxAI_DEV_BKP3" {
# #   name                = "MDIxAI_DEV_BKP3"
# #   managed_instance_id = azurerm_mssql_managed_instance.MF_MDI_CC_CORESQLMI.id

# #   point_in_time_restore {
# #     restore_point_in_time = "2024-07-05T12:01:31Z"
# #     source_database_id    = "/subscriptions/5d225f46-3a3f-4729-a5ec-dffd77831244/resourceGroups/MF_MDI_CC-RG/providers/Microsoft.Sql/managedInstances/mf-mdi-cc-coresqlmi/databases/MDIxAI_DEV"
# #   }

# #   # prevent the possibility of accidental data loss
# #   lifecycle {
# #     prevent_destroy = true
# #   }
# # }
# ############################################################################
# #                      Azure Route table
# ############################################################################

resource "azurerm_route_table" "MF_MDI_CC_SQLMI-rt" {
  name                = "MF_DM_CC_SQLMI-rt"
  location            = "Canada Central"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name

  #Is the Internet route intentional?
  route {
    name           = "Internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
  route {
    name                   = "VDI_172.25.35.0_24"
    address_prefix         = "172.25.35.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.125.251.4"
  }
  route {
    name                   = "VDI_172.16.0.0_16"
    address_prefix         = "172.16.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.125.251.4"
  }
  route {
    name                   = "VDI_172.19.0.0_16"
    address_prefix         = "172.19.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.125.251.4"
  }
  route {
    name                   = "VDI_172.29.0.0_16"
    address_prefix         = "172.29.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.125.251.4"
  }

  route {
    name           = "VnetLocal"
    address_prefix = "10.124.155.32/27"
    next_hop_type  = "VnetLocal"
  }

  route {
    name           = "AD"
    address_prefix = "AzureActiveDirectory"
    next_hop_type  = "Internet"
  }

  route {
    name           = "OneDs"
    address_prefix = "OneDsCollector"
    next_hop_type  = "Internet"
  }

  route {
    name           = "Storage_central"
    address_prefix = "Storage.canadacentral"
    next_hop_type  = "Internet"
  }

  route {
    name           = "Storage_east"
    address_prefix = "Storage.canadaeast"
    next_hop_type  = "Internet"
  }

  route {
    name                   = "VDI_172.25.30.0_23"
    address_prefix         = "172.25.30.0/23"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.125.251.4"
  }
}
