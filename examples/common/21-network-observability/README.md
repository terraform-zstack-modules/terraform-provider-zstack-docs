# 21-network-observability

Creates flow and port-mirror observability resources.

These resources are environment-sensitive. Confirm collector server addresses,
ports, mirror network UUIDs, and source/destination endpoint formats before
applying.

## Inputs

Set collector, flow meter, port mirror, network UUID, and endpoint variables in
`terraform.tfvars`. Review the traffic capture scope before applying.

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

Run `terraform destroy` when observability resources should stop collecting or
mirroring traffic.
