# 11-load-balancer-web

Creates a VIP, load balancer, listener, and server group for a web service.

This example does not register backend VM NICs because backend membership can
vary by environment and provider version. Use the output UUIDs as the base for
backend attachment workflows supported in your environment.

## Inputs

Set the public L3 network pattern, VIP name, load balancer name, listener name,
server group name, frontend port, and backend port in `terraform.tfvars`.

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

Run `terraform destroy` when the VIP, load balancer, listener, and server group
should be removed.
