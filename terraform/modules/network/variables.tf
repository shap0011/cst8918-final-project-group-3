variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/14"]
}

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
  default     = ["prod", "test", "dev", "admin"]
}

variable "subnet_prefixes" {
  description = "Address prefixes for the subnets"
  type        = list(string)
  default     = [
    "10.0.0.0/16",
    "10.1.0.0/16",
    "10.2.0.0/16",
    "10.3.0.0/16"
  ]
}