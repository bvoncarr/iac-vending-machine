terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "vending" {
  name     = "iac-vending-rg"
  location = "centralus"
}

locals {
  requests = {
    for f in fileset("${path.module}/requests", "*.yaml") :
    trimsuffix(f, ".yaml") => yamldecode(file("${path.module}/requests/${f}"))
  }
}

module "storage" {
  for_each = local.requests
  source   = "./modules/azure-storage"

  name                = each.value.name
  region              = each.value.region
  resource_group_name = azurerm_resource_group.vending.name
  tags                = each.value.tags
}
