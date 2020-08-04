terraform {
  backend "local" {}
}

data "terraform_remote_state" "layer-01" {
  backend = "local"
  config = {
    path = "../plan-01/terraform.tfstate"
  }
}