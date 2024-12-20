// accept license of Aviatrix Controller
data "http" "controller_image_info" {
  url = format("https://cdn.%s.sre.aviatrix.com/image-details/arm_controller_image_details.json", var.environment)

  request_headers = {
    "Accept" = "application/json"
  }
}

resource "azurerm_marketplace_agreement" "controller_mp_agreement" {
  count = var.accept_controller_subscription ? 1 : 0

  publisher = jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"]["Azure ARM"]["publisher"]
  offer     = jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"]["Azure ARM"]["offer"]
  plan      = jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"]["Azure ARM"]["sku"]
}

// accept license of Aviatrix Copilot
data "http" "copilot_image_info" {
  url = format("https://cdn.%s.sre.aviatrix.com/image-details/arm_copilot_image_details.json", var.environment)

  request_headers = {
    "Accept" = "application/json"
  }
}

resource "azurerm_marketplace_agreement" "copilot_mp_agreement" {
  count = var.accept_copilot_subscription ? 1 : 0

  publisher = jsondecode(data.http.copilot_image_info.response_body)["BYOL"]["Azure ARM"]["publisher"]
  offer     = jsondecode(data.http.copilot_image_info.response_body)["BYOL"]["Azure ARM"]["offer"]
  plan      = jsondecode(data.http.copilot_image_info.response_body)["BYOL"]["Azure ARM"]["sku"]
}
