module "azure_marketplace_agreement" {
  source = "./modules/azure_marketplace_agreement"

  accept_controller_subscription = true #Default
  accept_copilot_subscription    = true #Default
}
