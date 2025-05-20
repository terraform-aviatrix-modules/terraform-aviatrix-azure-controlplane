// accept license of Aviatrix Controller
data "http" "controller_image_info" {
  url = "https://cdn.prod.sre.aviatrix.com/image-details/arm_controller_image_details.json"

  request_headers = {
    "Accept" = "application/json"
  }
}

data "http" "copilot_image_info" {
  url = "https://cdn.prod.sre.aviatrix.com/image-details/arm_copilot_image_details.json"

  request_headers = {
    "Accept" = "application/json"
  }
}

locals {
  controller_urn = format("%s:%s:%s:%s",
    jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"]["Azure ARM"]["publisher"],
    jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"]["Azure ARM"]["offer"],
    jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"]["Azure ARM"]["sku"],
    jsondecode(data.http.controller_image_info.response_body)["g4"]["amd64"]["Azure ARM"]["version"]
  )
  copilot_urn = format("%s:%s:%s:%s",
    jsondecode(data.http.copilot_image_info.response_body)["BYOL"]["Azure ARM"]["publisher"],
    jsondecode(data.http.copilot_image_info.response_body)["BYOL"]["Azure ARM"]["offer"],
    jsondecode(data.http.copilot_image_info.response_body)["BYOL"]["Azure ARM"]["sku"],
    jsondecode(data.http.copilot_image_info.response_body)["BYOL"]["Azure ARM"]["version"]
  )
}

resource "null_resource" "run_python_script" {
  # This provisioner will execute when the resource is created or updated.
  provisioner "local-exec" {
    command = "python3 ${path.module}/accept_license.py '${local.controller_urn}' '${local.copilot_urn}'"
  }
}
