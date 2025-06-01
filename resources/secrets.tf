resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "ssh_private_key_pem" {
  name         = "ssh-private-key-pem"
  value        = tls_private_key.ssh_key.private_key_pem
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    tls_private_key.ssh_key
  ]
}

resource "azurerm_key_vault_secret" "ssh_private_key_openssh" {
  name         = "ssh-private-key-openssh"
  value        = tls_private_key.ssh_key.private_key_openssh
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    tls_private_key.ssh_key
  ]
}

resource "azurerm_key_vault_secret" "ssh_public_key_pem" {
  name         = "ssh-public-key-pem"
  value        = tls_private_key.ssh_key.public_key_pem
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    tls_private_key.ssh_key
  ]
}

resource "azurerm_key_vault_secret" "ssh_public_key_openssh" {
  name         = "ssh-public-key-openssh"
  value        = tls_private_key.ssh_key.public_key_openssh
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    tls_private_key.ssh_key
  ]
}

resource "azurerm_key_vault_secret" "client_certificate" {
  name         = "aks-client-certificate"
  value        = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    tls_private_key.ssh_key,
    azurerm_kubernetes_cluster.aks
  ]
}

resource "azurerm_key_vault_secret" "kube_config" {
  name         = "aks-kube-config"
  value        = azurerm_kubernetes_cluster.aks.kube_config_raw
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    tls_private_key.ssh_key,
    azurerm_kubernetes_cluster.aks
  ]
}
