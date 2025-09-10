variable "accept_controller_subscription" {
  description = "Toggles the acceptance of the Controller subscription"
  default     = true
  type        = bool
}

variable "accept_copilot_subscription" {
  description = "Toggles the acceptance of the copilot subscription"
  default     = true
  type        = bool
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
