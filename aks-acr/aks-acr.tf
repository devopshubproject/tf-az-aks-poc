# ##################################################
# # Azure Private DNS Zone
# ##################################################

# resource "azurerm_private_dns_zone" "pvtdns" {
#  name                = "laya.privatelink.eastus2.azmk8s.io"
#  resource_group_name = "${azurerm_resource_group.rg.name}"
# }

# resource "azurerm_container_registry" "acr" {
#  name                = "imagetwotire"
#  resource_group_name = azurerm_resource_group.rg.name
#  location            = azurerm_resource_group.rg.location
#  sku                 = "Basic"
#  admin_enabled       = true
# }

# resource "azurerm_role_assignment" "aksrole" {
#  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#  role_definition_name             = "AcrPull"
#  scope                            = azurerm_container_registry.acr.id
#  skip_service_principal_aad_check = true
# }
