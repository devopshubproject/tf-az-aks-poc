##################################################
# Provider
##################################################

provider "azurerm" {
 features {}
}

data "azurerm_subscription" "current" {}


##################################################
# locals for tagging
##################################################
locals {
 common_tags = {
   Owner       = var.owner
   Environment = var.environment
   Cost_center = var.cost_center
   Application = var.app_name
 }
}

##################################################
# Azure resource group
##################################################
resource "azurerm_resource_group" "rg" {
 name     = var.environment + "-" + var.app_name + "-rg"
 location = var.location
}

##################################################
# Azure Vnet
##################################################
data "azurerm_virtual_network" "vnet" {
 name                = var.environment + "-" + var.app_name + "-vnet"
 resource_group_name = var.environment + "-" + var.app_name + "-network-rg"
}


##################################################
# Azure Subnet
##################################################
data "azurerm_subnet" "subnet" {
 name                 = "${var.environment}-${var.app_name}-subnet"
 virtual_network_name = "${data.azurerm_virtual_network.vnet.name}"
 resource_group_name  = "${data.azurerm_virtual_network.vnet.resource_group_name}"
}

##################################################
# Application security group
##################################################
resource "azurerm_application_security_group" "asg" {
 name                = "${var.environment}-${var.app_name}-asg"
 location            = "${var.location}"
 resource_group_name = "${azurerm_resource_group.rg.name}"
 tags                = "${local.common_tags}"
}


##################################################
# Azure Private DNS Zone
##################################################

resource "azurerm_private_dns_zone" "pvtdns" {
 name                = "laya.privatelink.eastus2.azmk8s.io"
 resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_container_registry" "acr" {
 name                = "imagetwotire"
 resource_group_name = azurerm_resource_group.demoresourcegroup.name
 location            = azurerm_resource_group.demoresourcegroup.location
 sku                 = "Basic"
 admin_enabled       = true
}

resource "azurerm_role_assignment" "aksrole" {
 principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
 role_definition_name             = "AcrPull"
 scope                            = azurerm_container_registry.acr.id
 skip_service_principal_aad_check = true
}

##################################################
# Azure Kubernetes Cluster
##################################################

resource "azurerm_kubernetes_cluster" "aks" {
 name                = "${var.environment}-${local.app_name}-cluster"
 resource_group_name = azurerm_resource_group.rg.name
 location            = var.location
 node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"
 dns_prefix          = "${local.app_name}-dns"
 http_application_routing_enabled = var.application_routing_enabled

 identity {
   type = "SystemAssigned"
 }

 default_node_pool {
   name                 = "default"
   vm_size              = "Standard_DS2_v3"
   orchestrator_version = data.azurerm_kubernetes_cluster_versions.current.latest_version
   zones                = [1, 2, 3]
   enable_auto_scaling  = true
   node_count           = 1
   max_count            = 3
   min_count            = 1
   os_disk_size_gb      = 30
   type                 = "VirtualMachineScaleSets"
   upgrade_settings {
     max_surge = "10%"
   }
   node_labels = {
     "nodepool-type"    = "system"
     "environment"      = "dev"
     "nodepoolos"       = "linux"
     "app"              = "system-apps" 
   } 
   tags = {
     "nodepool-type"    = "system"
     "environment"      = "dev"
     "nodepoolos"       = "linux"
     "app"              = "system-apps" 
   } 
 }

 linux_profile {
   admin_username = var.username

   ssh_key {
     key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
   }
 }

 network_profile {
   network_plugin    = "azure"
   network_policy    = "azure"
   dns_service_ip    = "192.168.1.10"
   service_cidr      = "192.168.1.0/24"
   load_balancer_sku = "standard"
 }

 addon_profile {
   azure_policy {
     enabled = true
   }
   aci_connector_linux {
     enabled = true
   }
   kube_dashboard {
     enabled = true
   }
   oms_agent {
     enabled                    = true
     log_analytics_workspace_id = "laya_funapp_workspace"
   }
 }
}


##################################################
# Azure Kubernetes Node Pool
##################################################

resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
 name                  = "${var.environment}-${local.app_name}-nodepool"
 kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
 vm_size               = "Standard_DS2_v2"
 node_count            = 1

 // Node Configuration
 orchestrator_version   = "1.21.2"
 mode                   = "System"
 enable_auto_scaling    = true
 max_count              = 5
 min_count              = 1
 os_disk_size_gb        = 128
 os_disk_type           = "Managed"
# availability_zones     = ["1", "2", "3"]
#   enable_node_public_ip  = false
 node_labels            = { "nodeType" = "internal" }
 node_taints            = ["CriticalAddonsOnly=true:NoSchedule"]
 enable_host_encryption = false
 priority               = "Regular"

 // Scaling
 max_pods             = 110
 enable_node_public_ip = false
#   node_public_ip_prefix_id = azurerm_public_ip.example.id

 // Network Configuration
 subnet_id                = azurerm_subnet.subnet.id
 vnet_subnet_id           = azurerm_subnet.example.id
#   node_public_ip_prefix_id = azurerm_public_ip.example.id

 // System Assigned Identity
 assign_identity   = true
#   identity_ids      = [azurerm_user_assigned_identity.example.id]

 // Upgrade Settings
 upgrade_settings = {
   max_unavailable = "1"
   max_surge       = "1"
 }

 // Maintenance Window
 maintenance_window = {
   daily_maintenance_hour = 2
   maintenance_exclusion = ["Sunday", "Saturday"]
 }

 // Tags
 tags = {
   Environment = "Production"
 }
}


##################################################
# AKS Extension for Monitoring
##################################################

resource "azurerm_kubernetes_cluster_extension" "aks_ext" {
   name                = "example-extension"
   cluster_id          = azurerm_kubernetes_cluster.aks.id
   resource_group = azurerm_kubernetes_cluster.aks.node_resource_group
   extension_type      = "Microsoft.Insights/monitoringAgents"
   publisher           = "Microsoft.EnterpriseCloud.Monitoring"
   type                = "OMSAgentForLinux"
   version             = "1.13"

   auto_upgrade_minor_version = true
   protected_settings         = jsonencode({
       "workspaceKey" = "workspace-key"
   })
   settings = jsonencode({
       "workspaceId" = "workspace-id"
   })

   // Timeout Settings
   create_timeout      = "20m"
   delete_timeout      = "15m"
   read_timeout        = "5m"
   update_timeout      = "20m"
   wait_for_replica_set = true

   // Retry Settings
   max_retry_attempts = 5
   retry_wait        = "10s"

   // Additional Tags
   tags = {
       Environment = "Production"
       Owner       = "DevOps Team"
   }

   // Plan argument
   plan = true

   depends_on = [azurerm_kubernetes_cluster.aks]
}
