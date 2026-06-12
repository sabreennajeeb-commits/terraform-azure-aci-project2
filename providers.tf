terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.117.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "sabreen-ritaj-rahaf-tfstate-rg"
    storage_account_name = "srrtfstate89165"
    container_name       = "tfstate"
    key                  = "project2-aci.tfstate"
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
}