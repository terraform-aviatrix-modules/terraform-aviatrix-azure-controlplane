variable "app_name" {
  type        = string
  description = "Azure AD App Name for Aviatrix Controller Build Up"
  default     = "aviatrix_controller_app"
}

variable "app_password_validity_length" {
  type        = string
  description = "Number of hours from the apply time. Will be converted to the ISO 8601 extended date and time format automatically"
  default     = "730h"
}

variable "create_custom_role" {
  type        = bool
  description = "Enable creation of custom role in stead of using contributor permissions"
  default     = false
}

variable "aviatrix_role_names" {
  type        = map(string)
  description = "Aviatrix role names for use by the controller"
  default = {
    "read_only_name"  = "aviatrix-read-only"
    "service_name"    = "aviatrix-service"
    "transit_gw_name" = "aviatrix-transit-gateways"
    "backup_name"     = "aviatrix-backup"
  }
}

variable "use_existing_mp_agreement" {
  type        = bool
  description = "Flag to indicate whether to use an existing marketplace agreement"
  default     = false
}

variable "subscription_ids" {
  type        = list(string)
  description = "Subscriptions with the Aviatrix gateways. Aviatrix role will be created in the first one. Controller will have read-only access to this list"
  default     = []
}

variable "controller_rg" {
  type        = string
  description = "Controller RG used for roles if resource group level scope enabled"
  default     = ""
}

variable "aviatrix_rgs" {
  description = "Resorce groups with the Aviatrix managed entities. Controller permissions to modify resources in these RGs"
  type        = map(list(string))
  default     = {}
}

