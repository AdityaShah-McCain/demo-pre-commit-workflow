resource "azurerm_log_analytics_workspace" "MF_MDI_CC_CORE_LAW" {
  name                = var.cc_core_law_name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  sku                 = var.cc_core_law_sku
  retention_in_days   = 30
  tags                = local.tag_list_1
  # lifecycle {
  #   prevent_destroy = true
  # }
}
