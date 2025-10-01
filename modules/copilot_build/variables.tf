variable "location" {
  type        = string
  description = "Resource Group Location for Aviatrix Copilot"
  default     = "West US"
}

variable "copilot_name" {
  type        = string
  description = "Customized Name for Aviatrix Copilot"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR for copilot VNET"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR for copilot subnet"
  default     = "10.0.1.0/24"
}

variable "use_existing_public_ip" {
  type        = bool
  description = "Flag to indicate whether to use an existing public ip"
  default     = false
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name, only required when use_existing_public_ip is true"
  default     = ""
}

variable "use_existing_vnet" {
  type        = bool
  description = "Flag to indicate whether to use an existing VNET"
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name. Required when use_existing_resource_group is true or when using existing public IP or vnet."
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID, only required when use_existing_vnet is true"
  default     = ""
}

variable "virtual_machine_admin_username" {
  type        = string
  description = "Admin Username for the copilot virtual machine"
}

variable "virtual_machine_admin_password" {
  type        = string
  description = "Admin Password for the copilot virtual machine"
  default     = ""
}

variable "virtual_machine_size" {
  type        = string
  description = "Virtual Machine size for the copilot"
  default     = "Standard_B4ms"
}

variable "add_ssh_key" {
  type        = bool
  description = "Flag to indicate whether to add an SSH key"
  default     = false
}

variable "use_existing_ssh_key" {
  type        = bool
  description = "Flag to indicate whether to use an existing SSH key"
  default     = false
}

variable "ssh_public_key_file_path" {
  type        = string
  description = "File path to the SSH public key"
  default     = ""
}

variable "ssh_public_key_file_content" {
  type        = string
  description = "File content of the SSH public key"
  default     = ""
}

variable "allowed_cidrs" {
  type = map(object({
    priority = string,
    protocol = string,
    ports    = set(string),
    cidrs    = set(string),
  }))
}

variable "os_disk_name" {
  type        = string
  default     = ""
  description = "OS disk name of the copilot virtual machine"
}

variable "os_disk_size" {
  type        = number
  description = "OS disk size for copilot"
  default     = 30

  validation {
    condition     = var.os_disk_size >= 30
    error_message = "The minimum os size is 30G."
  }
}

variable "default_data_disk_name" {
  type        = string
  description = "Name of default data disk."
  default     = "default-data-disk"
}

variable "default_data_disk_size" {
  default     = 0
  type        = number
  description = "Size of default data disk. If not set, no default data disk will be created."
}

variable "additional_disks" {
  default = {}
  type = map(object({
    managed_disk_id = string,
    lun             = string,
  }))
}

variable "private_mode" {
  type        = bool
  description = "Flag to indicate whether the copilot is for private mode"
  default     = false
}

variable "is_cluster" {
  type        = bool
  description = "Flag to indicate whether the copilot is for a cluster"
  default     = false
}

variable "controller_public_ip" {
  type        = string
  description = "Controller public IP"
  default     = "0.0.0.0"
}

variable "controller_private_ip" {
  type        = string
  description = "Controller private IP"
}

variable "image_version" {
  type        = string
  description = "Version of the Aviatrix Copilot image to use. Set to 'latest' to use the most recent version."
  default     = "latest"
  nullable    = false
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

locals {
  ssh_key             = var.add_ssh_key ? (var.use_existing_ssh_key == false ? tls_private_key.key_pair_material[0].public_key_openssh : (var.ssh_public_key_file_path != "" ? file(var.ssh_public_key_file_path) : var.ssh_public_key_file_content)) : ""
  controller_ip       = var.private_mode ? var.controller_private_ip : var.controller_public_ip
  validate_public_ips = (var.private_mode == false && var.controller_public_ip == "0.0.0.0") ? tobool("Please pass in valid controller_public_ip when private_mode is false.") : true
  image_version       = var.image_version == "latest" ? jsondecode(data.http.image_info.response_body)["BYOL"]["Azure ARM"]["version"] : var.image_version

  custom_data = <<EOF
#!/bin/bash
jq '.config.controllerIp="${local.controller_ip}" | .config.controllerPublicIp="${local.controller_ip}" | .config.isCluster=${var.is_cluster}' /etc/copilot/db.json > /etc/copilot/db.json.tmp
mv /etc/copilot/db.json.tmp /etc/copilot/db.json
EOF
}
