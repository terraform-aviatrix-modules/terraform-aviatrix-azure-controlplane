// accept license of Aviatrix Controller
resource "null_resource" "accept_controller_license" {
   provisioner "local-exec" {
       command = "python3 ./accept_controller_mp.py"
       working_dir = "${path.module}"
   }
}

resource "null_resource" "accept_copilot_license" {
   provisioner "local-exec" {
       command = "python3 ./accept_copilot_mp.py"
       working_dir = "${path.module}"
   }
}