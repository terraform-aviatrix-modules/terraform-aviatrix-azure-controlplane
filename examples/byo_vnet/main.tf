provider "azurerm" {
  features {}
  skip_provider_registration = true
}

variable "region" {
  default = "East US"
  description = "This is the region containing the existing Resource Group that your VNET is in."
}

variable "rg_name" {
  default = "CHANGEME"
  description = "This the existing Resource Group that your VNET is in."
}

variable "vnet_name" {
  default = "CHANGEME"
  description = "This the existing VNET you will deploy Aviatrix into. You can identify details for the VNET and Resource Group by looking at https://portal.azure.com/#browse/Microsoft.Network%2FvirtualNetworks"
}

variable "subnet_name" {
  default = "Aviatrix-Controlplane-Subnet" # Can be customized
  description = "This is the name of the subnet that will be created to deploy Aviatrix into."
}

variable "vnet_cidr" {
  default = "CHANGEME"
  description = "This is the Address Space of the target VNET, you can get this information from the VNET in the Azure portal by clicking on the VNET name."
}

resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.region
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  vnet_name           = var.vnet_name
  vnet_location       = var.region
  use_for_each        = true
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_cidr] #Use a separate CIDR for gateways, to optimize usable IP space for workloads.
  subnet_prefixes = [
    cidrsubnet(var.vnet_cidr, 3, 0),
  ]
  subnet_names = [
    var.subnet_name,
  ]

  depends_on = [
    azurerm_resource_group.this
  ]
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.0.0"

  controller_name           = "AviatrixControlplane" # Can be customized
  incoming_ssl_cidrs        = ["1.2.3.4"] # FROM UI
  controller_admin_email    = "admin@domain.com" # FROM UI
  controller_admin_password = "mysecretpassword" # FROM UI
  account_email             = "admin@domain.com" # FROM UI
  access_account_name       = "Azure"
  customer_id               = "xxxxxxx-abu-xxxxxxxxx" # FROM UI
  location                  = var.region # FROM UI

  use_existing_vnet   = true
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.vnet.vnet_subnets[0]
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name

  depends_on = [module.vnet]
}

output "controlplane_data" {
  value = module.control_plane
}
