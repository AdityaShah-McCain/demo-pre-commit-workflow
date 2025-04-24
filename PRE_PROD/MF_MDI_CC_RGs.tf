resource "azurerm_resource_group" "MF_MDI_CC-RG" {
  name     = var.cc_core_resource_group_name
  location = var.cc_location
  tags     = local.tag_list_1

}


resource "azurerm_resource_group" "MF_MDI_CC_STORAGE-RG" {
  name     = var.cc_storage_resource_group_name
  location = var.storage_location
  tags     = local.tag_list_1
  lifecycle {
    prevent_destroy = true
  }
}
