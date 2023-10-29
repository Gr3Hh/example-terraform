## Introduction
This repository contains terraform code for the submitted task.  

* **tfstate_storage** contains a terraform code to create a bucket for the tfstates storage.
* **organization_accounts** contains a terraform code to create accounts in organization if it's required.
* **iam** contains a terraform code to create required accounts and roles
* **modules** contains the modules used in this task


## Requirements
* `awscli`
* `tfenv` | `terraform` | something simular


## Quick Start
1. Install `awscli` and setup profile for first account `aws configure --profile=first`
2. Install `tfenv` and install terraform `tfenv install 1.2.1`
3. (Optional) Create bucket for storage tfstate files using directory `tfstate_storage` => *If it's not required comment **backend "s3"** block in every terraform directory*
4. (Optional) Create an organization if it's required and add accounts using `organization_accounts` directory. Fill emails in variable file
5. Add configuration for second account `aws configure --profile=second`
6. Create all users / groups / roles using `iam` directory


### Terraform usage
```
cd ${required_directory}
terraform init
terraform apply
```