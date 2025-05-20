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
