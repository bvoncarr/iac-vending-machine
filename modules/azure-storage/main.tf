resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = merge(var.tags, {
    provisioned-by = "iac-vending-machine"
  })

  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}

output "storage_account_id" {
  value = azurerm_storage_account.this.id
}
