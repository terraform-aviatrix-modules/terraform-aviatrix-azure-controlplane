locals {
  azure_key = var.cloud_type == "china" ? "ARM CHINA" : "Azure ARM"
  # Controller image need to support Azure China
  controller_data = jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"][local.azure_key]
  copilot_data    = jsondecode(data.http.copilot_image_info.response_body)["BYOL"][local.azure_key]
}

# Fetch controller image information
data "http" "controller_image_info" {
  url = format("https://cdn.%s.sre.aviatrix.com/image-details/arm_controller_image_details.json", var.environment)

  request_headers = {
    "Accept" = "application/json"
  }
}

# Fetch copilot image information
data "http" "copilot_image_info" {
  url = format("https://cdn.%s.sre.aviatrix.com/image-details/arm_copilot_image_details.json", var.environment)

  request_headers = {
    "Accept" = "application/json"
  }
}

# Check if the controller marketplace agreement is accepted
data "azurerm_marketplace_agreement" "controller" {
  publisher = local.controller_data["publisher"]
  offer     = local.controller_data["offer"]
  plan      = local.controller_data["sku"]
}

# Check if the copilot marketplace agreement is accepted
data "azurerm_marketplace_agreement" "copilot" {
  publisher = local.copilot_data["publisher"]
  offer     = local.copilot_data["offer"]
  plan      = local.copilot_data["sku"]
}

#Accept marketplace agreement, if not already accepted
resource "azurerm_marketplace_agreement" "controller_mp_agreement" {
  count = var.accept_controller_subscription && !data.azurerm_marketplace_agreement.controller.accepted ? 1 : 0

  publisher = local.controller_data["publisher"]
  offer     = local.controller_data["offer"]
  plan      = local.controller_data["sku"]
}

resource "azurerm_marketplace_agreement" "copilot_mp_agreement" {
  count = var.accept_copilot_subscription && !data.azurerm_marketplace_agreement.copilot.accepted ? 1 : 0

  publisher = local.copilot_data["publisher"]
  offer     = local.copilot_data["offer"]
  plan      = local.copilot_data["sku"]
}
