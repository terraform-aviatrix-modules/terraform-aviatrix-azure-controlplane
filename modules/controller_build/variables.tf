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

variable "create_storage_account" {
  type        = bool
  default     = true
  description = "Storage account used for the controller backup and terraform state"
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

variable "copilot_ips" {
  description = "The list of Copilot IP's, for security group management."
  type        = list(string)
  default     = []
  nullable    = false
}
