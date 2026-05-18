# 04-create-10-vms

Creates multiple VMs with stable `for_each` keys.

Prefer this pattern over `count` when customers will add or remove individual
VMs later. Stable keys reduce accidental resource replacement.

## Inputs

Edit `terraform.tfvars` with the image, L3 network, instance offering, and VM
map for the target environment. Keep VM map keys stable after the first apply.

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

Run `terraform destroy` only after confirming all VMs in the map can be removed.
