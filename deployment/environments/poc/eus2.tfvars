azure_tenant_id = "c61caa41-16ec-4420-a923-a4e57eaec482"
subscription_id = "5800813f-4e42-4b82-aa30-1a16f2c6f231"

allowed_ip_ranges = ["47.197.121.134"]

aks_config = {
  kubernetes_version = "1.33.0"
  sku_tier = "Standard"
  local_account_disabled = true
  admin_username = "adminforpargocdoc"

  identity = {
    type = "SystemAssigned"
  }  

  azure_rbac_enabled = true
  cluster_admin_aad_groups = []

  workload_identity_enabled = true
  oidc_issuer_enabled = true
  api_server_access_profile = {
    # authorized_ip_ranges = ["47.197.121.134"]
  }

  load_balancer_sku = "standard"

  default_node_pool = {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D4_v2" 
  }
}

