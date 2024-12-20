module "copilot_build" {
  source = "./modules/copilot_build"

  vnet_cidr                      = "10.0.0.0/24"
  subnet_cidr                    = "10.0.0.0/24"
  controller_public_ip           = "123.2.3.4"
  controller_private_ip          = "10.2.3.4"
  copilot_name                   = "my_copilot"
  virtual_machine_admin_username = "avxadmin"
  virtual_machine_admin_password = "my_password"
  default_data_disk_size         = "100"
  location                       = "East US"

  allowed_cidrs = {
    "tcp_cidrs" = {
      priority = "100"
      protocol = "Tcp"
      ports    = ["443"]
      cidrs    = ["1.2.3.4/32"]
    }
    "udp_cidrs" = {
      priority = "200"
      protocol = "Udp"
      ports    = ["5000", "31283"]
      cidrs    = ["123.2.3.4"]
    }
  }
}
