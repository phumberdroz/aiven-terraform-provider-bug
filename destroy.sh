#!/bin/bash


cd plan-02
terraform workspace select development
terraform destroy -auto-approve
terraform workspace select staging
terraform destroy -auto-approve
terraform workspace select production
terraform destroy -auto-approve
cd ../plan-01
terraform destroy -auto-approve