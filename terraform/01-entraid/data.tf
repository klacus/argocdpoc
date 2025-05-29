data "azuread_domains" "default" {
  only_initial = true
}

data "azurerm_client_config" "current" {}
