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
  enable_auto_scaling = false
}

module "app" {
  source = "../../modules/app"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  acr_name   = "group3testacr"
  redis_name = "group3-test-redis"

  image_name = "weather-app"
  image_tag  = "latest"
}