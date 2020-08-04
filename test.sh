#!/bin/bash

cd plan-01
terraform apply
cd ../plan-02
terraform workspace new development || true
terraform workspace new staging || true
terraform workspace new production || true
terraform workspace select development
terraform apply
terraform workspace select staging
terraform apply
terraform workspace select production
terraform apply

# Show the error
terraform workspace select development
terraform plan
terraform workspace select staging
terraform plan
terraform workspace select production
terraform plan