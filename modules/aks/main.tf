resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.monitor.id
    }
  }
}

resource "azurerm_log_analytics_workspace" "monitor" {
  name                = "aks-monitor-workspace"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "aks-high-cpu"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = "Alert when CPU > 80%"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_group.id
  }
}

resource "azurerm_monitor_action_group" "alert_group" {
  name                = "aks-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "aksalerts"

  email_receiver {
    name          = "admin"
    email_address = var.alert_email
  }
}