# 07-vpc

Creates a basic VPC L3 network with an initial subnet CIDR.

This example looks up the existing L2 network and virtual router with data
sources. Narrow `l2_network_name_pattern` and `virtual_router_name_pattern`
before applying if the broad defaults match more than one candidate.

## Inputs

Set the L2 network, virtual router, CIDR, and naming variables in
`terraform.tfvars`. Confirm the route and subnet design with the network owner.

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

Run `terraform destroy` only after confirming no workloads depend on the VPC
resources created by this example.
