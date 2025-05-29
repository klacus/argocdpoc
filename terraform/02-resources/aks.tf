resource "azurerm_kubernetes_cluster" "aks" {

  depends_on = [
    azurerm_resource_group.rg
    #     azurerm_role_assignment.aks_subnet # need this to associate with custom route table
  ]

  name                = var.app_name
  location            = var.environment.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.app_name

  kubernetes_version     = var.aks_config.kubernetes_version
  sku_tier               = var.aks_config.sku_tier
  local_account_disabled = var.aks_config.local_account_disabled

  # TODO: Configure EntraID authentication for AKS

  identity {
    type = var.aks_config.identity.type
  }

  oidc_issuer_enabled       = var.aks_config.oidc_issuer_enabled
  workload_identity_enabled = var.aks_config.workload_identity_enabled
  api_server_access_profile {
    authorized_ip_ranges = var.allowed_ip_ranges
  }

  # Enabled RBAC with AAD integration
  azure_active_directory_role_based_access_control {
    tenant_id              = var.azure_tenant_id
    azure_rbac_enabled     = var.aks_config.azure_rbac_enabled
    admin_group_object_ids = [data.azuread_group.engineering.object_id, data.azuread_group.engineering_managers.object_id]
  }

  node_resource_group = "${var.app_name}-${var.environment.location_code}-${var.environment.lifecycle_code}-nodes"

  default_node_pool {
    name       = var.aks_config.default_node_pool.name
    node_count = var.aks_config.default_node_pool.node_count
    vm_size    = var.aks_config.default_node_pool.vm_size
  }
  # The POC does not define additional nodepools than the default to save costs.

  linux_profile {
    admin_username = var.aks_config.admin_username
    ssh_key {
      key_data = tls_private_key.ssh_key.public_key_openssh
    }
  }

  tags = local.tags
}

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config_raw
#   sensitive = true
# }
