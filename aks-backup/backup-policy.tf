##################################################
# AKS Backup Policy
##################################################

# resource "azurerm_data_protection_backup_policy_kubernetes_cluster" "aks_bp" {
#   name                = var.backup_policy_name
#   resource_group_name = azurerm_data_protection_backup_vault.aks_bv.resource_group_name
#   vault_name          = azurerm_data_protection_backup_vault.aks_bv.name

#   backup_repeating_time_intervals = ["R/2023-05-23T02:30:00+00:00/P1W"]

#   retention_rule {
#     name     = "Daily"
#     priority = 25

#     life_cycle {
#       duration        = "P84D"
#       data_store_type = "OperationalStore"
#     }

#     criteria {
#       days_of_week           = ["Thursday"]
#       months_of_year         = ["November"]
#       weeks_of_month         = ["First"]
#       scheduled_backup_times = ["2023-05-23T02:30:00Z"]
#     }
#   }

#   default_retention_rule {
#     life_cycle {
#       duration        = "P14D"
#       data_store_type = "OperationalStore"
#     }
#   }
# }
