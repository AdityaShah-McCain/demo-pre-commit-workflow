
terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform_Azure_Backend-RG"
    storage_account_name = "mfterraformstatesa"
    container_name       = "terraform-backend"
    key                  = "1104.tfstate"
    subscription_id      = "65763622-4bd1-45e6-82fc-2f11e3663439"
  }
  required_version = "1.9.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.2.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }

}
