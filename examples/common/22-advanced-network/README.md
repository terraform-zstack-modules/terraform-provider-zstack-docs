# 22-advanced-network

Creates advanced networking resources:

- IPsec connection
- policy route rule set
- policy route rule

Confirm VIP UUID, peer address, authentication key, virtual router UUID, route
table UUID, and route policy values before applying.
If `protocol` is set, use `TCP`, `UDP`, or `ICMP`.

## Inputs

Set VIP UUID, peer address, authentication key, route table UUID, destination
CIDR, protocol, and rule number in `terraform.tfvars`. Pass authentication keys
through sensitive variables or a secret store.

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

Run `terraform destroy` only after confirming the IPsec and policy route
resources are no longer in use.
