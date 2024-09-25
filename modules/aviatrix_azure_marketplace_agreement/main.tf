// accept license of Aviatrix Controller
resource "azurerm_marketplace_agreement" "aviatrix_mp_agreement" {
  publisher = jsondecode(data.http.image_info.response_body)["g3"]["amd64"]["Azure ARM"]["publisher"]
  offer     = jsondecode(data.http.image_info.response_body)["g3"]["amd64"]["Azure ARM"]["offer"]
  plan      = jsondecode(data.http.image_info.response_body)["g3"]["amd64"]["Azure ARM"]["sku"]
}

data "http" "image_info" {
  url = "https://cdn.prod.sre.aviatrix.com/image-details/arm_controller_image_details.json"

  request_headers = {
    "Accept" = "application/json"
  }
}
