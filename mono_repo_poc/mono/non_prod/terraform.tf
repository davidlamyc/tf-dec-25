terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id = local.client_id
  client_secret = local.client_secret
  tenant_id = local.tenant_id
  subscription_id = local.subscription_id
}