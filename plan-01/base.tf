terraform {
  backend "local" {}
}
variable "aiven_api_token" {
  type = string
}
provider "aiven" {
  api_token = var.aiven_api_token
}
resource "random_string" "test" {
  length = 4
  upper = false
  special = false
}

resource "aiven_account" "spectrm" {
  name = "spectrm${random_string.test.result}"
}

resource "aiven_account_team" "members" {
  account_id = aiven_account.spectrm.account_id
  name       = "Account Members"
}

output "aiven" {
  value = {
    account_name = aiven_account.spectrm.name
  }
}