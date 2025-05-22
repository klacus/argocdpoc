provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  required_version = "~> 1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4"
    }
  }

  backend "local" {
    path = "../terraform.tfstate"
  }
}
