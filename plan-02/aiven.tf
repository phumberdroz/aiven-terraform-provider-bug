variable "aiven_api_token" {
  description = "Admin Token from: https://portal.timescale.cloud/profile/auth"
  type        = string
}

variable "aiven_project_name" {
  type = string
}

provider "aiven" {
  api_token = var.aiven_api_token
}

resource "random_string" "aiven_suffix" {
  length  = 8
  special = false
  upper   = false
}

data "aiven_account" "spectrm" {
  name = data.terraform_remote_state.layer-01.outputs.aiven.account_name
}

data "aiven_account_team" "owners" {
  account_id = data.aiven_account.spectrm.account_id
  name       = "Account Owners"
}

data "aiven_account_team" "members" {
  account_id = data.aiven_account.spectrm.account_id
  name       = "Account Members"
}

resource "aiven_project" "stage" {
  //  copy_from_project = data.aiven_project.spectrm.project
  project    = "spectrm-${terraform.workspace}-${random_string.aiven_suffix.result}"
  account_id = data.aiven_account.spectrm.account_id
  lifecycle {
    ignore_changes = [
      billing_emails,
      billing_address,
      card_id,
      country_code,
      technical_emails
    ]
  }
}

resource "aiven_account_team_project" "owners" {
  account_id   = data.aiven_account.spectrm.account_id
  team_id      = data.aiven_account_team.owners.team_id
  project_name = aiven_project.stage.project
  team_type    = "admin"
}

resource "aiven_account_team_project" "members" {
  account_id   = data.aiven_account.spectrm.account_id
  team_id      = data.aiven_account_team.members.team_id
  project_name = aiven_project.stage.project
  team_type    = "read_only"
}
