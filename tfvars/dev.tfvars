# General
environment = "dev"

# Tags
owner    = "Prem"
company  = "Ladvik Solutions"
app_name = "DevOpsHub"
cost_center = "Ladvik Solutions"

# Core
account = "1234567890" # Replace with your Azure Subscription number
region  = "us-west-2"  # Replace with your desired Azure region

# Networking
vpc_cidr           = "10.0.0.0/16"
pub_subnet_cidr    = "10.0.1.0/24"
pvt_subnet_cidr    = "10.0.2.0/24"
availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
allocation_id = ["eipalloc-1a2b3c", "eipalloc-4d5e6f"]

# Load Balancer
health_check_path = "/health"
amis = "ami-0123456789"
instance_type = "t2.micro"

# Auto Scaling
autoscale_min     = 1
autoscale_max     = 2
autoscale_desired = 1
