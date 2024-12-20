variable "access_account_name" {
  type        = string
  description = "aviatrix controller access account name"
}

variable "account_email" {
  type        = string
  description = "aviatrix controller access account email"
}

variable "app_name" {
  type        = string
  description = "Azure AD App Name for Aviatrix Controller Build Up"
  default     = "aviatrix_controller_app"
}

variable "customer_id" {
  type        = string
  description = "aviatrix customer license id"
}

variable "controller_admin_email" {
  type        = string
  description = "aviatrix controller admin email address"
}

variable "controller_admin_password" {
  type        = string
  description = "aviatrix controller admin password"
}

variable "controller_name" {
  type        = string
  description = "Customized Name for Aviatrix Controller"
  default     = "Aviatrix-Controller"

  validation {
    condition     = can(regex("^[^\\\\/\"\\[\\]:|<>+=;,?*@&~!#$%^()_{}']*$", var.controller_name))
    error_message = "Input string cannot contain the following special characters: `\\` `/` `\"` `[` `]` `:` `|` `<` `>` `+` `=` `;` `,` `?` `*` `@` `&` `~` `!` `#` `$` `%` `^` `(` `)` `_` `{` `}` `'`"
  }
}

variable "copilot_name" {
  type        = string
  description = "Customized Name for Aviatrix Copilot"
  default     = "Aviatrix-Copilot"
}

variable "controlplane_subnet_cidr" {
  type        = string
  description = "CIDR for controlplane subnet."
  default     = "10.0.0.0/24"
}

variable "controller_version" {
  type        = string
  description = "Aviatrix Controller version"
  default     = "latest"
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

variable "controlplane_vnet_cidr" {
  type        = string
  description = "CIDR for controller VNET."
  default     = "10.0.0.0/24"
}

variable "create_custom_role" {
  type        = bool
  description = "Enable creation of custom role in stead of using contributor permissions"
  default     = false
}

variable "incoming_ssl_cidrs" {
  type        = list(string)
  description = "Incoming cidrs for security group used by controller"
}

variable "location" {
  type        = string
  description = "Resource Group Location for Aviatrix Controller"
  default     = "West US"
}

variable "use_existing_vnet" {
  type        = bool
  description = "Flag to indicate whether to use an existing VNET"
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name, only required when use_existing_vnet is true"
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "VNET name, only required when use_existing_vnet is true"
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "subnet name, only required when use_existing_vnet is true"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID, only required when use_existing_vnet is true"
  default     = ""
}

variable "virtual_machine_admin_username" {
  default = "avx_admin"
}

variable "virtual_machine_admin_password" {
  default = ""
}

variable "module_config" {
  default = {
    accept_controller_subscription = true,
    accept_copilot_subscription    = true,
    controller_deployment          = true,
    controller_initialization      = true,
    copilot_deployment             = true,
    copilot_initialization         = true,
    app_registration               = true,
    account_onboarding             = true,
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
