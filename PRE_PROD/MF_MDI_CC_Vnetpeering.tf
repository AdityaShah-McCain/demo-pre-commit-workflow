# data "azurerm_resource_group" "MF_Core_Firewall-RG" {
#   provider = azurerm.MF-Core-Infrastructure-Prod-Subscription
#   name     = "MF_Core_Firewall-RG"
# }
# data "azurerm_virtual_network" "MF_Core_Firewall-VNet" {
#   provider            = azurerm.MF-Core-Infrastructure-Prod-Subscription
#   name                = "MF_CC_Core_Prod_Firewall-Vnet"
#   resource_group_name = "MF_Core_Firewall-RG"
# }

#############################################################################
#                            API and CORE Virtual Network Peering
#############################################################################

resource "azurerm_virtual_network_peering" "MF_MDI_CC_CORE-VNET" {

  name                      = "MF_MDI_CC_CORE-VNET_to_API_Vnet"
  resource_group_name       = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name      = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name
  remote_virtual_network_id = azurerm_virtual_network.MF_MDI_CC_API-VNET.id
}

resource "azurerm_virtual_network_peering" "MF_MDI_CC_API-VNET" {

  name                      = "MF_MDI_CC_API-VNET_to_Core_Vnet"
  resource_group_name       = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name      = azurerm_virtual_network.MF_MDI_CC_API-VNET.name
  remote_virtual_network_id = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.id
}


# #############################################################################
# #                            McCain PROD Firewall Peering
# #############################################################################

# resource "azurerm_virtual_network_peering" "MF_MDI_CC_CORE-VNET_to_MF_CC_Core_Firewall-VNet_Peering" {
#   provider                     = azurerm.MF-MDI-DEV-Subscription
#   resource_group_name          = azurerm_resource_group.MF_MDI_CC-RG.name
#   name                         = join("_", [azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name, "_To_", data.azurerm_virtual_network.MF_Core_Firewall-VNet.name])
#   virtual_network_name         = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name
#   remote_virtual_network_id    = data.azurerm_virtual_network.MF_Core_Firewall-VNet.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic       = true
#   allow_gateway_transit         = false
#   use_remote_gateways           = false

#   lifecycle {
#     prevent_destroy = false
#   }
# }

# resource "azurerm_virtual_network_peering" "MF_CC_Core_Firewall-VNet_to_MF_MDI_CC_CORE-VNET" {
#   provider                     = azurerm.MF-Core-Infrastructure-Prod-Subscription
#   resource_group_name          = data.azurerm_resource_group.MF_Core_Firewall-RG.name
#   name                         = join("_", [data.azurerm_virtual_network.MF_Core_Firewall-VNet.name, "_To_", azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name])
#   virtual_network_name         = data.azurerm_virtual_network.MF_Core_Firewall-VNet.name
#   remote_virtual_network_id    = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = true
#   allow_gateway_transit         = false
#   use_remote_gateways           = false

#   lifecycle {
#     prevent_destroy = false
#   }
# }
