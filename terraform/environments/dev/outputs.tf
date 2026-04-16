output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "virtual_network_name" {
  value = module.network.virtual_network_name
}

output "subnet_names" {
  value = module.network.subnet_names
}