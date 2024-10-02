provider "azurerm" {
  features {}
}

variable "region" {
  default = "West Europe"
}

variable "name" {
  default = "Aviatrix-Controlplane"
}

variable "vnet_cidr" {
  default = "10.0.0.0/22"
}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.region
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  vnet_name           = var.name
  vnet_location       = var.region
  use_for_each        = true
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_cidr] #Use a separate CIDR for gateways, to optimize usable IP space for workloads.
  subnet_prefixes = [
    cidrsubnet(var.vnet_cidr, 3, 0),
  ]
  subnet_names = [
    "AviatrixControlPlane",
  ]

  depends_on = [
    azurerm_resource_group.this
  ]
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.0.0"

  controller_name           = "my_controller"
  incoming_ssl_cidr         = ["1.2.3.4"]
  controller_admin_email    = "admin@domain.com"
  controller_admin_password = "mysecretpassword"
  account_email             = "admin@domain.com"
  access_account_name       = "Azure"
  customer_id               = "xxxxxxx-abu-xxxxxxxxx"
  location                  = var.region

  use_existing_vnet   = true
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.vnet.vnet_subnets[0]
  vnet_name           = var.name
  subnet_name         = var.name

  depends_on = [module.vnet]
}

output "controlplane_data" {
  value = module.control_plane
}
