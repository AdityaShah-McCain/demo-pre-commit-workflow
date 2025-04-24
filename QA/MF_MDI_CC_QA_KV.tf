data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "MF_MDI_CC_CORE-KEY-VAULT" {
  name                            = var.cc_core_key_vault
  location                        = azurerm_resource_group.MF_MDI_CC-RG.location
  resource_group_name             = azurerm_resource_group.MF_MDI_CC-RG.name
  enabled_for_disk_encryption     = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  enabled_for_template_deployment = true
  sku_name                        = var.cc_core_key_vault_sku

}


resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_AUTH_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_AUTH_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-MDIXAIAUTHSERVICE.identity[0].principal_id
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_DDH_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-ddh.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_DDH_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-ddh.identity[0].principal_id
  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY.principal_id
  certificate_permissions = [
    "Get", "List" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_role_assignment" "MF_MDI_CC_CORE_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY.principal_id
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_DDDS_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-DDDS.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
    # azurerm_user_assigned_identity.MF_MDI_CC_CORE_APPGW-USER-IDENTITY
  ]

}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_DDDS_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-DDDS.identity[0].principal_id

}


resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_dcl_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-dcl.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
  ]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "MF_MDI_CC_CORE_ACA_dcl_KEY_VAULT_ROLE_ASSGN" {

  scope                = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_container_app.MF_MDI_CC-CAPP-dcl.identity[0].principal_id
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_key_vault_access_policy" "MF_MDI_CC_CORE_ACA_cid_KEY_VAULT_ACCESS_POLICY" {

  key_vault_id = azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT.id
  tenant_id    = var.MF_tenant_id
  object_id    = azurerm_container_app.MF_MDI_CC-CAPP-cid.identity[0].principal_id
  certificate_permissions = [
    "Get", "List", "GetIssuers", "ListIssuers" #, "Create", "Update", "GetIssuers",  "ListIssuers", "SetIssuers", "ManageIssuers"
  ]
  secret_permissions = [
    "Get", "List"
  ]
  key_permissions = [
    "Get", "List"
  ]
  depends_on = [
    azurerm_key_vault.MF_MDI_CC_CORE-KEY-VAULT,
  ]
  lifecycle {
    prevent_destroy = true
  }
}
