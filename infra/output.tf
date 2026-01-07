output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}
output "acr_login_server" {
  value = module.acr.acr_login_server
}
output "key_vault_uri" {
  value = module.key_vault.key_vault_uri
}
output "monitor_workspace_id" {
  value = module.aks.monitor_workspace_id
}