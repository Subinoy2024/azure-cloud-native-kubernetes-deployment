az group create --name tfstate-rg --location eastus
az storage account create --name tfstatestorage --resource-group tfstate-rg --sku Standard_LRS --encryption-services blob
az storage container create --name tfstate --account-name tfstatestorage
az cosmosdb create --name tfstatecosmos --resource-group tfstate-rg --kind GlobalDocumentDB --locations regionName=eastus failoverPriority=0
az cosmosdb mongodb database create --account-name tfstatecosmos --name tfstate-db --resource-group tfstate-rg