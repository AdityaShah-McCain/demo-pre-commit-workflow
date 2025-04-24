# Create an App Service Plan
resource "azurerm_app_service_plan" "MF_MDI_CC_CORE-appSP" {
  name                = var.MF_DM_CC_CORE-appSP_Name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  sku {
    tier = "Standard"
    size = "S3"
  }
}
# Create a Web App
resource "azurerm_windows_web_app" "MF-MDI-CC-CORE-Webapp" {

  name                = var.MF-DM-CC-CORE-Webapp_Name
  location            = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name = azurerm_resource_group.MF_MDI_CC-RG.name
  service_plan_id     = azurerm_app_service_plan.MF_MDI_CC_CORE-appSP.id
  site_config {
    always_on = true
  }
  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.17.0" # Example Node.js version
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      name, app_settings, site_config, tags, logs
    ]
  }

  identity {
    type = "SystemAssigned"
  }
}
