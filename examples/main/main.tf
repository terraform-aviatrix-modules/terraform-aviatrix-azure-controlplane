provider "azurerm" {
  features {}
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.0.0"

  controller_name               = "my_controller"
  incoming_ssl_cidr             = ["1.2.3.4"]
  avx_controller_admin_email    = "admin@domain.com"
  avx_controller_admin_password = "mysecretpassword"
  account_email                 = "admin@domain.com"
  access_account_name           = "Azure"
  customer_id                   = "xxxxxxx-abu-xxxxxxxxx"
}

output "controlplane_data" {
  value = module.control_plane
}
