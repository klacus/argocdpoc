
provider "azuread" {}

provider "azurerm" {
  features {}
  #  The subscription_id is required for the provider starting with terraform v4.
  subscription_id = var.subscription_id
}

terraform {
  required_version = "~> 1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 3"
    }
  }

  backend "azurerm" {
  }
}
