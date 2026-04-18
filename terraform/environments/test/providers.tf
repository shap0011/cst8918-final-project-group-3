terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "cst8918-final-project-group-3-backend"
    storage_account_name = "cst8918group3tfstate"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}