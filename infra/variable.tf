variable "resource_group_name" { default = "my-aks-rg" }
variable "resource_group_name_tfstate" { default = "tfstate-rg" }
variable "location" { default = "East US" }
variable "cluster_name" { default = "my-aks-cluster" }
variable "dns_prefix" { default = "myaks" }
variable "node_count" { default = 3 }
variable "vm_size" { default = "Standard_DS2_v2" }
variable "alert_email" { default = "your-email@example.com" }