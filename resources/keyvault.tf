resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.app_name}-${var.environment.location_code}-${var.environment.lifecycle_code}"
  location = var.environment.location

  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  public_network_access_enabled = true # Set to false if you want to restrict access to private endpoints only. It is recommended to set this true in a non-POC environment for safe access.
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules = var.allowed_ip_ranges
  }

  # TODO: Set up access policies to lock down access to the tenant Entra ID accounts
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", 
      "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", 
      "GetRotationPolicy","SetRotationPolicy"
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore","Set"
    ]

    storage_permissions = [
      "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", 
      "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
    ]

    certificate_permissions = [
      "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", 
      "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", 
      "Restore", "SetIssuers", "Update"
    ]
  }

  tags     = local.tags
}