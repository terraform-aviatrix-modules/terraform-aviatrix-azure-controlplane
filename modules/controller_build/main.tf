/**
 * # Aviatrix Controller Build
 *
 * This module builds and launches the Aviatrix Controller VM instance.
 */

# 1. Create an Azure resource group
resource "azurerm_resource_group" "controller_rg" {
  count    = var.use_existing_resource_group ? 0 : 1
  location = var.location
  name     = "${var.controller_name}-rg"
}

# 2. Create the Virtual Network and Subnet
//  Create the Virtual Network
resource "azurerm_virtual_network" "controller_vnet" {
  count               = var.use_existing_vnet ? 0 : 1
  address_space       = [var.controller_vnet_cidr]
  location            = var.location
  name                = "${var.controller_name}-vnet"
  resource_group_name = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
}

//  Create the Subnet
resource "azurerm_subnet" "controller_subnet" {
  count                = var.use_existing_vnet ? 0 : 1
  name                 = "${var.controller_name}-subnet"
  resource_group_name  = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
  virtual_network_name = azurerm_virtual_network.controller_vnet[0].name
  address_prefixes     = [var.controller_subnet_cidr]

  depends_on = [azurerm_resource_group.controller_rg]
}

// 3. Create or Read Public IP Address
resource "azurerm_public_ip" "controller_public_ip" {
  count               = var.use_existing_public_ip ? 0 : 1
  allocation_method   = "Static"
  location            = var.location
  name                = "${var.controller_name}-public-ip"
  sku                 = "Standard"
  resource_group_name = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name

  depends_on = [azurerm_resource_group.controller_rg]
}

data "azurerm_public_ip" "controller_public_ip" {
  count               = var.use_existing_public_ip ? 1 : 0
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

// 4. Create the Security Group
resource "azurerm_network_security_group" "controller_nsg" {
  location            = var.location
  name                = "${var.controller_name}-security-group"
  resource_group_name = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name

  depends_on = [azurerm_resource_group.controller_rg]
}

resource "azurerm_network_security_rule" "controller_nsg_rule_https" {
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "https"
  priority                    = "200"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefixes     = var.incoming_ssl_cidrs
  destination_address_prefix  = "*"
  description                 = "https-for-vm-management"
  resource_group_name         = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
  network_security_group_name = azurerm_network_security_group.controller_nsg.name
}

# 5. Create the Virtual Network Interface Card
//  associate the public IP address with a VM by assigning it to a nic
resource "azurerm_network_interface" "controller_nic" {
  location            = var.location
  name                = "${var.controller_name}-network-interface-card"
  resource_group_name = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
  ip_configuration {
    name                          = "${var.controller_name}-nic"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.use_existing_vnet == false ? azurerm_subnet.controller_subnet[0].id : var.subnet_id
    public_ip_address_id          = var.use_existing_public_ip ? data.azurerm_public_ip.controller_public_ip[0].id : azurerm_public_ip.controller_public_ip[0].id
  }
}

# 6. Associate the Security Group to the NIC
resource "azurerm_network_interface_security_group_association" "controller_nic_sg" {
  network_interface_id      = azurerm_network_interface.controller_nic.id
  network_security_group_id = azurerm_network_security_group.controller_nsg.id

  // https://github.com/hashicorp/terraform/issues/24663
  depends_on = [
    azurerm_network_interface.controller_nic,
    azurerm_network_security_group.controller_nsg
  ]
}

# 7. Create the virtual machine
resource "azurerm_linux_virtual_machine" "controller_vm" {
  admin_username                  = var.controller_virtual_machine_admin_username
  admin_password                  = var.controller_virtual_machine_admin_password
  name                            = "${var.controller_name}-vm"
  disable_password_authentication = false
  location                        = var.location
  network_interface_ids           = [azurerm_network_interface.controller_nic.id]
  resource_group_name             = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
  size                            = var.controller_virtual_machine_size
  custom_data = base64encode(templatefile("${path.module}/cloud-init.tftpl", {
    controller_version  = var.controller_version
    environment         = var.environment
    registry_auth_token = var.registry_auth_token
  }))

  //disk
  os_disk {
    name                 = "aviatrix-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = jsondecode(data.http.image_info.response_body)["g4"]["amd64"]["Azure ARM"]["offer"]
    publisher = jsondecode(data.http.image_info.response_body)["g4"]["amd64"]["Azure ARM"]["publisher"]
    sku       = jsondecode(data.http.image_info.response_body)["g4"]["amd64"]["Azure ARM"]["sku"]
    version   = jsondecode(data.http.image_info.response_body)["g4"]["amd64"]["Azure ARM"]["version"]
  }

  plan {
    name      = jsondecode(data.http.image_info.response_body)["g4"]["amd64"]["Azure ARM"]["sku"]
    product   = jsondecode(data.http.image_info.response_body)["g4"]["amd64"]["Azure ARM"]["offer"]
    publisher = jsondecode(data.http.image_info.response_body)["g4"]["amd64"]["Azure ARM"]["publisher"]
  }

  // https://github.com/hashicorp/terraform/issues/24663
  depends_on = [azurerm_network_interface.controller_nic]

  lifecycle {
    ignore_changes = [source_image_reference, plan]
  }
}

data "http" "image_info" {
  url = format("https://cdn.%s.sre.aviatrix.com/image-details/arm_controller_image_details.json", var.environment)

  request_headers = {
    "Accept" = "application/json"
  }
}

# 8. Create storage for backup and terraform state
resource "azurerm_storage_account" "controller" {
  count = var.create_storage_account ? 1 : 0

  name                     = local.storage_account_name
  resource_group_name      = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Aviatrix controller backup and terraform state"
  }
}

resource "azurerm_storage_container" "controller_backup" {
  count = var.create_storage_account ? 1 : 0

  name                  = "aviatrix-controller-backup"
  storage_account_name  = azurerm_storage_account.controller[0].name
  container_access_type = "private"
}

resource "azurerm_storage_container" "terraform_state" {
  count = var.create_storage_account ? 1 : 0

  name                  = "aviatrix-terraform-state"
  storage_account_name  = azurerm_storage_account.controller[0].name
  container_access_type = "private"
}
