
resource "azurerm_container_registry" "MF_MDI_CC_CORE_ACR" {
  name                = var.cc_core_acr_name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  sku                 = var.cc_core_acr_sku
  admin_enabled       = true
  tags                = local.tag_list_1
}
