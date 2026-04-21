output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "cluster_name" {
  value = module.aks.cluster_name
}

output "cluster_id" {
  value = module.aks.cluster_id
}

output "redis_hostname" {
  value = module.app.redis_hostname
}
