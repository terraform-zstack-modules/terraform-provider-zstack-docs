# 08-volume

Creates a VM and attaches a data volume to it.

This example uses the provider resource `zstack_volume` directly. Use VM
`data_disks` only when the data disks should be created as part of the VM
lifecycle.

## Inputs

Set the image, L3 network, instance offering, disk offering, VM name, and volume
name in `terraform.tfvars`.

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

Run `terraform destroy` only after confirming the data volume can be deleted.
