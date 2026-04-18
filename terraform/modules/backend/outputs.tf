output "resource_group_name" {
  description = "Resource group containing the backend storage"
  value       = azurerm_resource_group.this.name
}

output "storage_account_name" {
  description = "Storage account name for the Terraform backend"
  value       = azurerm_storage_account.this.name
}

output "container_name" {
  description = "Blob container name for Terraform state files"
  value       = azurerm_storage_container.this.name
}
