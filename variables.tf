##### Global Variable #####

#### Tags ####

variable "owner" {
  type        = string
  description = "The name of the infra provisioner or owner"
}
variable "environment" {
  type        = string
  description = "The environment name"
}

variable "cost_center" {
  type        = string
  description = "The cost_center name for this project"
}
variable "app_name" {
  type        = string
  description = "Application name of IFRS project"
}

variable "location" {
  type        = string
  description = "Cluster location, used for resource group too"
}

#### Variables ####

variable "application_routing_enabled" {
  type        = bool
  description = "HTTP Application routing"
  default     = true
}

### Node details ###

variable "default_node_count" {
  type        = number
  description = "The number of node for pool"
}

variable "default_disk_size" {
  type        = string
  description = "The disk size for nodepool"
}

variable "default_vm_size" {
  type        = string
  description = "The VM size for nodepool"
}

variable "default_min_count" {
  type        = number
  description = "The min no. of nodepool on auto scale"
}

variable "default_max_count" {
  type        = number
  description = "The max no. of nodepool on auto scale"
}

variable "enable_auto_scaling" {
  type        = string
  description = "The define to turn on/off scale"
  default     = true
}

### Network ###

### Kube version
variable "k8s_version" {
  type        = string
  description = "The version number of kuberents for the cluster"
  default     = "1.29.1"
}

### ACR Details
