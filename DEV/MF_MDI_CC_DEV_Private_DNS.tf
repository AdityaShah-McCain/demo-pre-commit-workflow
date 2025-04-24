## Private DNS Zone for A record API Management
resource "azurerm_private_dns_zone" "MF_MDI_CC_CORE_APIMGT_PRIVATE_DNS_ZONE" {

  name                = var.cc_core_domain_name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  depends_on = [
    azurerm_api_management.MF-MDI-CC-APIMGT
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "MF_MDI_CC_CORE_APIMGT_PRIVATE_DNS_ZONE_VNET-LINK" {

  name                  = var.cc_core_apim_app_link
  resource_group_name   = azurerm_resource_group.MF_MDI_CC-RG.name
  private_dns_zone_name = azurerm_private_dns_zone.MF_MDI_CC_CORE_APIMGT_PRIVATE_DNS_ZONE.name
  virtual_network_id    = azurerm_virtual_network.MF_MDI_CC_API-VNET.id
}


resource "azurerm_private_dns_a_record" "MF_MDI_CC_CORE_APIMGT_PRIVATE_DNS_A_RECORD" {

  name                = var.cc_core_apim_api_a_record
  zone_name           = azurerm_private_dns_zone.MF_MDI_CC_CORE_APIMGT_PRIVATE_DNS_ZONE.name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  ttl                 = 300
  records             = ["${azurerm_api_management.MF-MDI-CC-APIMGT.private_ip_addresses[0]}"]

}

#### Private DNS Zone for A record for Container Apps
resource "azurerm_private_dns_zone" "MF_MDI_CC_PRDS_CAPPS_PRIVATE_DNS_ZONE" {

  name                = azurerm_container_app_environment.MF_MDI_CC-CAPPENV.default_domain
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  tags                = local.tag_list_1
  depends_on = [
    azurerm_container_app_environment.MF_MDI_CC-CAPPENV
  ]
  lifecycle {

    ignore_changes = [tags]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "MF_MDI_CC_PRDS_CORE_PRIVATE_DNS_ZONE_VNET-LINK" {

  name                  = var.cc_core_vnet_aca_app_link
  resource_group_name   = azurerm_resource_group.MF_MDI_CC-RG.name
  private_dns_zone_name = azurerm_private_dns_zone.MF_MDI_CC_PRDS_CAPPS_PRIVATE_DNS_ZONE.name
  virtual_network_id    = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.id
  tags                  = local.tag_list_1
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}

resource "azurerm_private_dns_a_record" "MF_MDI_CC_PRDS_CAPPS_PRIVATE_DNS_A_RECORD" {

  name                = "*"
  zone_name           = azurerm_private_dns_zone.MF_MDI_CC_PRDS_CAPPS_PRIVATE_DNS_ZONE.name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  ttl                 = 300
  records             = ["${azurerm_container_app_environment.MF_MDI_CC-CAPPENV.static_ip_address}"]
  tags                = local.tag_list_1
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "MF_MDI_CC_API_VNET_LINK_CAPPS_PRIVATE_DNS_ZONE" {

  name                  = var.cc_api_vnet_aca_app_link
  resource_group_name   = azurerm_resource_group.MF_MDI_CC-RG.name
  private_dns_zone_name = azurerm_private_dns_zone.MF_MDI_CC_PRDS_CAPPS_PRIVATE_DNS_ZONE.name
  virtual_network_id    = azurerm_virtual_network.MF_MDI_CC_API-VNET.id
  tags                  = local.tag_list_1
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}

#New private DNS Zone for Synapse#
####################################################################################
resource "azurerm_private_dns_zone" "MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE" {

  name                = "privatelink.sql.azuresynapse.net"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE_VNET-LINK" {

  name                  = "MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE_VNET-LINK"
  resource_group_name   = azurerm_resource_group.MF_MDI_CC-RG.name
  private_dns_zone_name = azurerm_private_dns_zone.MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE.name
  virtual_network_id    = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.id
}

resource "azurerm_private_dns_a_record" "MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE1" {

  name                = "azure-synapse-workspace-01-dev"
  zone_name           = azurerm_private_dns_zone.MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE.name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  ttl                 = 300
  records             = ["172.25.246.36"]

}


resource "azurerm_private_dns_a_record" "MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE2" {

  name                = "azure-synapse-workspace-01-dev"
  zone_name           = azurerm_private_dns_zone.MF_MDI_CC_CORE_SYNAPSE_PRIVATE_DNS_ZONE.name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  ttl                 = 300
  records             = ["172.25.246.36"]

}

#######################private zone for cosmos#####################
locals {
  private_dns_zones = {
    privatelink-documents-azure-com = "privatelink.documents.azure.com"
  }
}

resource "azurerm_private_dns_zone" "PRIVATE_DNS_ZONES" {

  for_each            = local.private_dns_zones
  name                = each.value
  resource_group_name = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  tags                = local.tag_list_1
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}

# Setup private dns links
resource "azurerm_private_dns_zone_virtual_network_link" "PRIVATE_DNS_NETWORK_LINKS" {

  for_each              = local.private_dns_zones
  name                  = "${azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name}-LINK"
  resource_group_name   = azurerm_resource_group.MF_MDI_CC_STORAGE-RG.name
  private_dns_zone_name = each.value
  virtual_network_id    = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.id
  depends_on            = [azurerm_private_dns_zone.PRIVATE_DNS_ZONES]
  tags                  = local.tag_list_1
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}
