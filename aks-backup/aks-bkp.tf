
# data "azurerm_client_config" "current" {}

##################################################
# AKS Extension for Backup
##################################################

# resource "azurerm_kubernetes_cluster_extension" "aks_bkp_ext" {
#   name              = "backup-extension"
#   cluster_id        = azurerm_kubernetes_cluster.aks.id
#   extension_type    = "Microsoft.DataProtection.Kubernetes"
#   release_train     = "stable"
#   release_namespace = "dataprotection-microsoft"
#   configuration_settings = {
#     "configuration.backupStorageLocation.bucket"                = azurerm_storage_container.container.name
#     "configuration.backupStorageLocation.config.resourceGroup"  = azurerm_storage_account.storage.resource_group_name
#     "configuration.backupStorageLocation.config.storageAccount" = azurerm_storage_account.storage.name
#     "configuration.backupStorageLocation.config.subscriptionId" = data.azurerm_client_config.current.subscription_id
#     "credentials.tenantId"                                      = data.azurerm_client_config.current.tenant_id
#   }
# }

# resource "azurerm_role_assignment" "aks_bkp_ext_role" {
#   scope                = azurerm_storage_account.storage.id
#   role_definition_name = "Storage Account Contributor"
#   principal_id         = azurerm_kubernetes_cluster_extension.aks_bkp_ext.aks_assigned_identity[0].principal_id
# }


# ##################################################
# AKS Trust Access
# ##################################################

# resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "aks_ta" {
#  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#  name                  = "trusted-access"
#  roles                 = ["Microsoft.DataProtection/backupVaults/backup-operator"]
#  source_resource_id    = azurerm_data_protection_backup_vault.backup-vault.id
# }
