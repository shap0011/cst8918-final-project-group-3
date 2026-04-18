variable "resource_group_name" {
  description = "Name of the resource group for the backend storage"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_name" {
  description = "Globally unique storage account name (3-24 chars, lowercase alphanumeric only)"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container for Terraform state files"
  type        = string
  default     = "tfstate"
}
