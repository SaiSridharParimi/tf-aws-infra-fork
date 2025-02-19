# tf-aws-infra

### Setting up Demo and Dev AWS Profiles
- Create IAM User for Demo and Dev Accounts
- Configure them in local PC `aws configure --profile dev/demo`
- Check the config file `vi ~/.aws/config`
- Check the credentials file `vi ~/.aws/credentials`
- Checking default configured users `aws configure list`
- To set variables in code (the profile that we set here becomes default) `export AWS_PROFILE=dev/demo` 
- Command to execute without setting deafult profile
`AWS_PROFILE=dev/demo terraform plan`
`AWS_PROFILE=dev/demo terraform apply`


### Running Terraform Script
- `cd tf-infra`
- `terraform init`
- `terraform fmt`
- `AWS_PROFILE=dev/demo terraform plan`
- `AWS_PROFILE=dev/demo terraform apply`