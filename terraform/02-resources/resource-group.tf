resource "azurerm_resource_group" "rg" {
  name     = "${var.app_name}-${var.environment.location_code}-${var.environment.lifecycle_code}"
  location = var.environment.location
  tags     = local.tags
}
