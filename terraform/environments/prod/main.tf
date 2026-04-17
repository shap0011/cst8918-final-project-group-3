resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

module "aks" {
  source = "../../modules/aks"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  cluster_name        = var.cluster_name
  dns_prefix          = var.dns_prefix
  node_count          = 1
  vm_size             = "Standard_B2s"
  kubernetes_version  = "1.32"
  enable_auto_scaling = true
  min_count           = 1
  max_count           = 3
}