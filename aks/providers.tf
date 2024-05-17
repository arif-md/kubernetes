provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # careful with this setting.
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.54.0"
    }
  }
}