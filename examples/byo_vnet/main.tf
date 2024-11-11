provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "0.9.0"

  controller_name           = "my_controller"
  incoming_ssl_cidrs        = ["1.2.3.4"]
  controller_admin_email    = "admin@domain.com"
  controller_admin_password = "mysecretpassword"
  account_email             = "admin@domain.com"
  access_account_name       = "Azure"
  customer_id               = "xxxxxxx-abu-xxxxxxxxx"
  location                  = var.region

  use_existing_vnet   = true
  resource_group_name = "my-rg"     #Put your resource group name
  vnet_name           = "my_vnet"   #Put your VNET name
  subnet_name         = "my_subnet" #Put your Subnet name
  subnet_id           = "xyz"       #Put your subnet ID
}

output "controlplane_data" {
  value = module.control_plane
}
