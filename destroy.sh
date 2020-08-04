#!/bin/bash


cd plan-02
terraform workspace select development
terraform destroy
terraform workspace select staging
terraform destroy
terraform workspace select production
terraform destroy
cd ../plan-01
terraform destroy