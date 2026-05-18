# 12-vpc-routing

Creates a basic VPC network and a route table with one route entry.

VPC and route attachment workflows can vary by ZStack environment. Confirm how
the route table should be associated with your virtual router or VPC before
using this in production.

## Inputs

Set the VPC, route table, destination CIDR, and route target variables in
`terraform.tfvars`. Review the plan with the network owner before applying.

## Run

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

## Cleanup

Run `terraform destroy` only after confirming the route entries are no longer in
use.
