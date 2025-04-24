# resource "azurerm_virtual_network" "MF_MDI_CC_CORE-VNET" {
#   name                = var.cc_core_vnet_name
#   resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
#   location            = azurerm_resource_group.MF_MDI_CC-RG.location
#   address_space       = ["10.124.176.0/21"]
#   tags                = local.tag_list_1
# }
resource "azurerm_virtual_network" "MF_MDI_CC_CORE-VNET" {
  name                = var.cc_core_vnet_name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  address_space       = ["10.124.88.0/21"]
  tags                = local.tag_list_1
}

resource "azurerm_virtual_network" "MF_MDI_CC_API-VNET" {

  name                = var.cc_api_vnet_name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  address_space       = ["10.124.81.0/24"]
  tags                = local.tag_list_1
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "azurerm_public_ip" "MF_MDI_CC_APIM_API-IP" {

  name                = var.cc_apim_public_ip
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  allocation_method   = "Static"
  sku                 = var.cc_core_public_ip_sku
  domain_name_label   = "mfdmccapimdev"
  tags                = local.tag_list_1
  # lifecycle {
  #   prevent_destroy = true
  # }
}

#                       Azure Networking
#############################################################################


resource "azurerm_subnet" "MF_MDI_CC_SQLMI-SNET" {

  name                 = "MF_DM_CC_PERF_SQLMI-SNET"
  resource_group_name  = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name
  address_prefixes     = ["10.124.91.32/27"]
  delegation {
    name = "sqlMI"
    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [delegation.0.service_delegation.0.actions]
  }
}

#############################################################################
#                       Azure NSG group
#############################################################################
resource "azurerm_network_security_group" "MF_MDI_CC_SQLMI-NSG" {

  name                = "MF_DM_CC_SQLMI-NSG"
  location            = "Canada Central"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "10.124.91.32/27"
  }

  security_rule {
    name                       = "allow_customport_3342"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "10.124.91.32/27"
  }

  security_rule {
    name                       = "allow_customport_1433"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "10.124.91.32/27"
  }
  security_rule {
    name                       = "allow_customport_11000-11999"
    priority                   = 1100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "11000-11999"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "10.124.91.32/27"
  }

  security_rule {
    name                       = "allow_customport_5022"
    priority                   = 1200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "10.124.91.32/27"
  }

  security_rule {
    name                       = "allow_customport"
    priority                   = 1300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3342"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



  security_rule {
    name                       = "allow_Outbound_AZCloud"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "AzureCloud"
  }

  security_rule {
    name                       = "allow_Outbound_AAD"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "AzureActiveDirectory"
  }

  security_rule {
    name                       = "allow_Outbound_OneDSCollector"
    priority                   = 102
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "OneDsCollector"
  }

  security_rule {
    name                       = "allow_Outbound_10.124.77.192_27"
    priority                   = 103
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "10.124.91.32/27"
  }

  security_rule {
    name                       = "allow_Outbound_StCanadacentral"
    priority                   = 104
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "Storage.canadacentral"
  }

  security_rule {
    name                       = "allow_Outbound_StCanadaeast"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "Storage.canadaeast"
  }

  security_rule {
    name                       = "allow_Outbound_Vnet"
    priority                   = 443
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "allow_Outbound_1433"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "allow_Outbound_11000-11999"
    priority                   = 1100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "11000-11999"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "allow_Outbound_VirtualNetwork"
    priority                   = 1200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5022"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "allow_Outbound_443"
    priority                   = 1300
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.91.32/27"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "allow_Outbound_AzureCloud"
    priority                   = 1400
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureCloud"
  }

  /* security_rule {
   name                       = "deny_10.124.77.192_27"
    priority                   = 4096
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }*/
}

#############################################################################
#                      NSG association
#############################################################################

resource "azurerm_subnet_network_security_group_association" "Nsg_association" {

  subnet_id                 = azurerm_subnet.MF_MDI_CC_SQLMI-SNET.id
  network_security_group_id = azurerm_network_security_group.MF_MDI_CC_SQLMI-NSG.id
}

#############################################################################
#                       Route table association
#############################################################################

resource "azurerm_subnet_route_table_association" "routetable_association" {
  subnet_id      = azurerm_subnet.MF_MDI_CC_SQLMI-SNET.id
  route_table_id = azurerm_route_table.MF_MDI_CC_SQLMI-rt.id
}
resource "azurerm_subnet_route_table_association" "routetable_association_afunc" {
  subnet_id      = azurerm_subnet.MF_MDI_CC_AFUNC-SNET.id
  route_table_id = azurerm_route_table.MF_MDI_CC_SQLMI-rt.id
}

#######   APIMGMT #######

resource "azurerm_subnet" "MF_MDI_CC_APIM-SNET" {
  name                 = var.cc_core_apimgt_subnet_name
  resource_group_name  = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name = azurerm_virtual_network.MF_MDI_CC_API-VNET.name
  address_prefixes     = ["10.124.81.64/26"]
  service_endpoints    = ["Microsoft.AzureCosmosDB", "Microsoft.Storage"]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_security_group" "MF_MDI_CC_APIM-NSG" {
  name                = var.cc_core_apimgt_nsg_NAME
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  tags                = local.tag_list_1

  security_rule {
    name                       = "AllowInternetAppGateway"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.81.0/24"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "ManagementAccess"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowTagCustom4290Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "4290"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowTagCustom6390Inbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6390"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowContainerApps"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.88.0/21"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AzureStorage"
    priority                   = 150
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
  }
  security_rule {
    name                       = "AllowAzureAD"
    priority                   = 160
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureActiveDirectory"
  }
  security_rule {
    name                       = "AllowAzureKeyVault"
    priority                   = 180
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureKeyVault"
  }
  security_rule {
    name                       = "AllowMetrics"
    priority                   = 190
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "1886"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureMonitor"
  }
  security_rule {
    name                       = "AllowAPIManagement"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "ApiManagement"
  } /*
  security_rule {
    name                       = "DenyAnyCustomAnyOutbound"
    priority                   = 230
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  */
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet_network_security_group_association" "MF_MDI_CC_APIM-NSG-ASSOC" {
  subnet_id                 = azurerm_subnet.MF_MDI_CC_APIM-SNET.id
  network_security_group_id = azurerm_network_security_group.MF_MDI_CC_APIM-NSG.id
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_subnet" "MF_MDI_CC_CAPPS-SNET" {
  name                 = "MF_DM_CC_CAPPS-SNET"
  resource_group_name  = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name
  address_prefixes     = ["10.124.88.0/23"]
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_network_security_group" "MF_MDI_CC_CAPPS-NSG" {
  name                = "MF_DM_CC_CAPPS-NSG"
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name

  security_rule {
    name                       = "IntraCommunication"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.88.0/23"
    destination_address_prefix = "10.124.88.0/23"
  }
  security_rule {
    name                       = "TrafficFromLoadBalancer"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "10.124.88.0/23"
  }
  security_rule {
    name                       = "AllowAPI3443"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowStorage"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
  }
  security_rule {
    name                       = "AzureMonitorTraffic"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.88.0/23"
    destination_address_prefix = "AzureMonitor"
  }
  security_rule {
    name                       = "AKSConnectionUDP"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1194"
    source_address_prefix      = "10.124.88.0/23"
    destination_address_prefix = "AzureCloud.CanadaCentral"
  }
  security_rule {
    name                       = "AKSConnectionTCP"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9000"
    source_address_prefix      = "10.124.88.0/23"
    destination_address_prefix = "AzureCloud.CanadaCentral"
  }
  security_rule {
    name                       = "IntraCommunication1"
    priority                   = 140
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.88.0/23"
    destination_address_prefix = "10.124.88.0/23"
  }
  security_rule {
    name                       = "AllowTagCustom443ADOutbound"
    priority                   = 150
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["10250", "10255", "10256"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureCosmosDB"
  }
  security_rule {
    name                       = "AllowTagAzureKeyVault"
    priority                   = 160
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureKeyVault"
  }
  security_rule {
    name                       = "AllowApiManagement"
    priority                   = 170
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "ApiManagement"
  }
  security_rule {
    name                       = "AllowAzureContainerRegistry"
    priority                   = 180
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureContainerRegistry"
  }
  security_rule {
    name                       = "AllowAzureMonitor"
    priority                   = 190
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureMonitor"
  }

  /*security_rule {
    name                       = "AllowInternet"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowInternetPowerPlatform"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureConnectors.CanadaCentral"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowInternetPowerBI"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "PowerBI"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "Allowcustom65200-65535"
    priority                   = 115
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowLoadBalancer"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "DenyAnyCustomAnyInbound"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAnyInternetOut"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }*/
  lifecycle {
    prevent_destroy = true
  }
  tags = local.tag_list_1
}

resource "azurerm_subnet_network_security_group_association" "MF_MDI_CC_CAPPS-NSG-ASSOC" {
  subnet_id                 = azurerm_subnet.MF_MDI_CC_CAPPS-SNET.id
  network_security_group_id = azurerm_network_security_group.MF_MDI_CC_CAPPS-NSG.id
  lifecycle {
    prevent_destroy = false
  }
}
#######   APPGW  ########

resource "azurerm_subnet" "MF_MDI_CC_APPGW-SNET" {
  name                              = var.cc_core_appgw_subnet_name
  resource_group_name               = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name              = azurerm_virtual_network.MF_MDI_CC_API-VNET.name
  address_prefixes                  = ["10.124.81.0/26"]
  private_endpoint_network_policies = "Enabled"
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_network_security_group" "MF_MDI_CC_APPGW-NSG" {

  name                = var.cc_core_appgw_nsg_NAME
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name


  security_rule {
    name                       = "AllowInternet"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowInternetPowerBI"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "PowerBI"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "Allowcustom65200-65535"
    priority                   = 115
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowLoadBalancer"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "DenyAnyCustomAnyInbound"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAnyInternetOut"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  security_rule {
    name                       = "AllowInternet"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }
  /*
  security_rule {
    name                       = "AllowInternetPowerPlatform"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureConnectors.CanadaCentral"
    destination_address_prefix = "VirtualNetwork"
  }
  */
  security_rule {
    name                       = "AllowInternetPowerBI"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "PowerBI"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "Allowcustom65200-65535"
    priority                   = 115
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowLoadBalancer"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "DenyAnyCustomAnyInbound"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAnyInternetOut"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = local.tag_list_1
}

resource "azurerm_subnet_network_security_group_association" "MF_MDI_CC_APPGW-NSG-ASSOC" {
  subnet_id                 = azurerm_subnet.MF_MDI_CC_APPGW-SNET.id
  network_security_group_id = azurerm_network_security_group.MF_MDI_CC_APPGW-NSG.id
  lifecycle {
    prevent_destroy = false
  }
}

#######   Remaining Sub nets #######

resource "azurerm_subnet" "MF_MDI_CC_AFUNC-SNET" {

  name                 = "MF_DM_CC_AFUNC-SNET"
  resource_group_name  = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name
  address_prefixes     = ["10.124.90.0/24"]
  lifecycle {
    prevent_destroy = true
  }
  delegation {
    name = "Microsoft.Web/serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action", ]
    }
  }
}
resource "azurerm_network_security_group" "MF_MDI_CC_AFUNC-NSG" {

  name                = "MF_DM_CC_AFUNC-NSG"
  location            = "Canada Central"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name


  security_rule {
    name                       = "allowcosmosDB"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "virtualNetwork"
    destination_address_prefix = "AzureCosmosDB"
  }

    security_rule {
    name                       = "allowPIWebAPI"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.124.90.0/24"
    destination_address_prefix = "172.29.8.96"
  }

  security_rule {
    name                       = "AllowKeyVault"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "virtualNetwork"
    destination_address_prefix = "AzureKeyVault"
  }

  security_rule {
    name                       = "AllowSQLMI"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3342"
    source_address_prefix      = "virtualNetwork"
    destination_address_prefix = "SqlManagement"
  }
}
#############################################################################
#                      NSG association
#############################################################################

resource "azurerm_subnet_network_security_group_association" "Nsg_associationafunc" {

  subnet_id                 = azurerm_subnet.MF_MDI_CC_AFUNC-SNET.id
  network_security_group_id = azurerm_network_security_group.MF_MDI_CC_AFUNC-NSG.id
}


resource "azurerm_subnet" "MF_MDI_CC_PLINK-SNET" {

  name                 = "MF_DM_CC_PLINK-SNET"
  resource_group_name  = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name
  address_prefixes     = ["10.124.91.64/26"]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "MF_MDI_CC_VMSS-SNET" {

  name                 = "MF_DM_CC_VMSS-SNET"
  resource_group_name  = azurerm_resource_group.MF_MDI_CC-RG.name
  virtual_network_name = azurerm_virtual_network.MF_MDI_CC_CORE-VNET.name
  address_prefixes     = ["10.124.91.0/27"]
  lifecycle {
    prevent_destroy = true
  }
  delegation {
    name = "Microsoft.StreamAnalytics.streamingJobs"

    service_delegation {
      name    = "Microsoft.StreamAnalytics/streamingJobs"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
    }
  }
}

###################################################################################
#Azure Route table for function app#
###################################################################################
# resource "azurerm_route_table" "MF_MDI_CC_AFUNC-rt" {

#   name                          = "MF_MDI_CC_AFUNC-rt"
#   location                      = "Canada Central"
#   resource_group_name           = azurerm_resource_group.MF_MDI_CC-RG.name

#   route {
#     name                   = "To_Synapse"
#     address_prefix         = "172.25.246.36/32"
#     next_hop_type          = "VirtualAppliance"
#     next_hop_in_ip_address = "10.125.251.4"
#   }
# ## Inorder to connect to Digital Infrastructure Dev DB##
#   route {
#     name                   = "VDI_172.25.0.0_16"
# 	  address_prefix         = "172.25.0.0/16"
# 	  next_hop_type          = "VirtualAppliance"
# 	  next_hop_in_ip_address = "10.125.251.4"
#   }
# }

# #############################################################################
# #                   Afunc Route table association
# #############################################################################

# resource "azurerm_subnet_route_table_association" "afunc_routetable_association" {

#   subnet_id      = azurerm_subnet.MF_MDI_CC_AFUNC-SNET.id
#   route_table_id = azurerm_route_table.MF_MDI_CC_AFUNC-rt.id
#   depends_on = [azurerm_route_table.MF_MDI_CC_AFUNC-rt]
# }
