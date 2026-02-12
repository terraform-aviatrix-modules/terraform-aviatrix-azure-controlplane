variable "location" {
  type        = string
  description = "Resource Group Location for Aviatrix Controller"
  default     = "West US"
}

variable "controller_name" {
  type        = string
  description = "Customized Name for Aviatrix Controller"
}

variable "controller_version" {
  type        = string
  description = "Aviatrix Controller version"
  default     = "latest"
}

variable "controller_vnet_cidr" {
  type        = string
  description = "CIDR for controller VNET."
  default     = "10.0.0.0/24"
}

variable "controller_subnet_cidr" {
  type        = string
  description = "CIDR for controller subnet."
  default     = "10.0.0.0/24"
}

variable "use_existing_public_ip" {
  type        = bool
  description = "Flag to indicate whether to use an existing public ip"
  default     = false
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name, only required when use_existing_public_ip is true"
  default     = ""
}

variable "use_existing_vnet" {
  type        = bool
  description = "Flag to indicate whether to use an existing VNET"
  default     = false
}

variable "use_existing_resource_group" {
  type        = bool
  description = "Flag to indicate whether to use an existing resource group"
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name. Required when use_existing_resource_group is true or when using existing public IP or vnet."
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "VNET name, only required when use_existing_vnet is true"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID, only required when use_existing_vnet is true"
  default     = ""
}

variable "controller_virtual_machine_admin_username" {
  type        = string
  description = "Admin Username for the controller virtual machine."
  default     = "aviatrix"
}

variable "controller_virtual_machine_admin_password" {
  type        = string
  description = "Admin Password for the controller virtual machine."
  default     = "aviatrix1234!"
}

variable "controller_virtual_machine_size" {
  type        = string
  description = "Virtual Machine size for the controller."
  default     = "Standard_A4_v2"
}

variable "incoming_ssl_cidrs" {
  type        = list(string)
  description = "Incoming cidrs for security group used by controller"
}

variable "incoming_service_tags" {
  type        = list(string)
  description = "Incoming service tags for security group used by controller"
  default     = []
  nullable    = false
}

variable "create_storage_account" {
  type        = bool
  default     = true
  description = "Storage account used for the controller backup and terraform state"
}

variable "cloud_type" {
  description = "Determines which cloud should we subscribe offer"
  type        = string
  default     = "commercial"
  validation {
    condition     = contains(["commercial", "china"], var.cloud_type)
    error_message = "The Azure cloud type must be either 'commercial' or 'china'."
  }
}

# terraform-docs-ignore
variable "environment" {
  description = "Determines the deployment environment. For internal use only."
  type        = string
  default     = "prod"
  nullable    = false

  validation {
    condition     = contains(["prod", "staging"], var.environment)
    error_message = "The environment must be either 'prod' or 'staging'."
  }
}

# terraform-docs-ignore
variable "registry_auth_token" {
  description = "The token used to authenticate to the controller artifact registry. For internal use only."
  type        = string
  default     = ""
  nullable    = false
}

variable "storage_account_name" {
  description = "Azure storage account name."
  type        = string
  default     = ""
  nullable    = false
}

resource "random_string" "storage_account_name_padding" {
  length  = 16
  upper   = false
  lower   = true
  special = false
}

variable "tags" {
  description = "Provide tags for resources created by the module"
  type        = map(string)
  default     = {}
}

locals {
  default_storage_account_name = substr(format("%s%s", lower(replace(var.controller_name, "-", "")), random_string.storage_account_name_padding.result), 0, 24) #Storage accounts require global unique names.
  storage_account_name         = var.storage_account_name == "" ? local.default_storage_account_name : var.storage_account_name

  cloud_init_prod = base64encode(templatefile("${path.module}/cloud-init-prod.tftpl", {
    controller_version = var.controller_version
    environment        = var.environment
  }))

  cloud_init_staging = base64encode(templatefile("${path.module}/cloud-init-staging.tftpl", {
    controller_version  = var.controller_version
    environment         = var.environment
    registry_auth_token = var.registry_auth_token
  }))

  cloud_init = var.environment == "staging" ? local.cloud_init_staging : local.cloud_init_prod
}
