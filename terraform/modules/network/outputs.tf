output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = azurerm_subnet.this[*].id
}

output "subnet_names" {
  description = "Names of the created subnets"
  value       = azurerm_subnet.this[*].name
}