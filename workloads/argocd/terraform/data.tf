data "azuread_domains" "default" {
  only_initial = true
}

data "azurerm_client_config" "current" {}

data "azuread_group" "engineering" {
  display_name = "Engineering Department"
  security_enabled = true
}

data "azuread_group" "engineering_managers" {
  display_name = "Engineering - Managers"
  security_enabled = true
}