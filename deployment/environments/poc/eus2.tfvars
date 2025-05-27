subscription_id = "5800813f-4e42-4b82-aa30-1a16f2c6f231"



aks_config = {
  kubernetes_version = "1.33.0"
  sku_tier = "Standard"
  local_account_disabled = true

  identity = {
    type = "SystemAssigned"
  }  

  workload_identity_enabled = true
  oidc_issuer_enabled = true
  api_server_access_profile = {
    authorized_ip_ranges = ["47.197.121.134"]
  }

  load_balancer_sku = "standard"

  default_node_pool = {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D4_v2" 
  }
}

