
resource_group_name  = "${var.environment}-tf-rg"
storage_account_name = "${var.app_name}fstate"
container_name       = "${var.environment}${var.app_name}state"
key                  = "terraform.${var.app_name}.tfstate"
access_key           = ""