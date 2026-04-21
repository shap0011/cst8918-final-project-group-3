variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for AKS"
  type        = string
}

variable "node_count" {
  description = "Initial node count"
  type        = number
}

variable "vm_size" {
  description = "VM size for nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "enable_auto_scaling" {
  description = "Enable autoscaling"
  type        = bool
  default     = false
}

variable "min_count" {
  description = "Minimum node count"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum node count"
  type        = number
  default     = 3
}