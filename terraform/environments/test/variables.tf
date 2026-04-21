variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "acr_name" {
  description = "Azure Container Registry name (shared across environments)"
  type        = string
}

variable "redis_name" {
  description = "Azure Cache for Redis name for test environment"
  type        = string
}
