resource "azurerm_resource_group" "tfstate" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstatestorage"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_encryption_source = "Microsoft.Storage"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

resource "azurerm_cosmosdb_account" "tfstate" {
  name                = "tfstatecosmos"
  location            = azurerm_resource_group.tfstate.location
  resource_group_name = azurerm_resource_group.tfstate.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.tfstate.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "tfstate" {
  name                = "tfstate-db"
  resource_group_name = azurerm_resource_group.tfstate.name
  account_name        = azurerm_cosmosdb_account.tfstate.name
}