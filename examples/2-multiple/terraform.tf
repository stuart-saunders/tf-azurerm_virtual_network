terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.30"
    }
  }
}

provider "azurerm" {
  features {}
}