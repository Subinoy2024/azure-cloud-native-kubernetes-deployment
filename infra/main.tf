terraform {
  # Initially, comment out the backend block. Run 'terraform init' and 'terraform apply' first.
  # After first apply, uncomment, run 'terraform init' again to migrate state.
  # backend "azurerm" {
  #   resource_group_name   = "tfstate-rg"
  #   storage_account_name  = "tfstatestorage"
  #   container_name        = "tfstate"
  #   key                   = "terraform.tfstate"
  #   use_azuread_auth      = true
  # }
}

provider "azurerm" {
  features {}
}

# Module for remote state (storage + CosmosDB)
module "remote_state" {
  source = "./modules/remote-state"

  resource_group_name = var.resource_group_name_tfstate
  location            = var.location
}

# Module for Key Vault
module "key_vault" {
  source = "./modules/key-vault"

  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
}

# Module for ACR
module "acr" {
  source = "./modules/acr"

  resource_group_name = var.resource_group_name
  location            = var.location
}

# Module for AKS and monitoring
module "aks" {
  source = "./modules/aks"

  resource_group_name = var.resource_group_name
  location            = var.location
  cluster_name        = var.cluster_name
  dns_prefix          = var.dns_prefix
  node_count          = var.node_count
  vm_size             = var.vm_size
  alert_email         = var.alert_email
}

data "azurerm_client_config" "current" {}