resource "azurerm_application_insights" "MF_MDI_CC_CORE_APP_INSIGHTS" {
  name                = var.cc_core_appinsights_name
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  workspace_id        = azurerm_log_analytics_workspace.MF_MDI_CC_CORE_LAW.id
  application_type    = "web"
  tags                = local.tag_list_1
}


resource "azurerm_application_insights" "MF-MDI-CC-AI-DDDS-AFUNC" {
  name                = "MF_DM-CC-APP-INSIGHTS-DDDS-AFUNC"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  workspace_id        = azurerm_log_analytics_workspace.MF_MDI_CC_CORE_LAW.id
  application_type    = "web"
  tags                = local.tag_list_1
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_application_insights" "MF-MDI-CC-AI-EXTERNALDATA-AFUNC" {
  name                = "MF_DM-CC-APP-INSIGHTS-EXTERNALDATA-AFUNC"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  workspace_id        = azurerm_log_analytics_workspace.MF_MDI_CC_CORE_LAW.id
  application_type    = "web"
  tags                = local.tag_list_1
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_application_insights" "MF-MDI-CC-AI-AUTO-SUBM-AFUNC" {
  name                = "MF_DM-CC-APP-INSIGHTS-AUTO-SUBM-AFUNC"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  workspace_id        = azurerm_log_analytics_workspace.MF_MDI_CC_CORE_LAW.id
  application_type    = "web"
  tags                = local.tag_list_1
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_application_insights" "MF-MDI-CC-AI-LIVESKU-AFUNC" {
  name                = "MF-MDI-CC-APP-INSIGHTS-LIVESKU-AFUNC"
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  workspace_id        = azurerm_log_analytics_workspace.MF_MDI_CC_CORE_LAW.id
  application_type    = "web"
  tags                = local.tag_list_1
  lifecycle {
    prevent_destroy = true
  }
}
