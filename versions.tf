terraform {
  required_version = ">= 1.3"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      // https://github.com/hashicorp/terraform-provider-azurerm/issues/24444
      version = "3.85.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}
