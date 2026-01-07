output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
output "monitor_workspace_id" {
  value = azurerm_log_analytics_workspace.monitor.id
}