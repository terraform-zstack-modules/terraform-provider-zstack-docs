# 03-create-vm

Creates one VM from an existing image, L3 network, and instance offering.

This example uses `network_interfaces`, which is the recommended VM networking
form. Do not use the old `l3_network_uuids` form for new examples.

## Inputs

Set the ZStack endpoint, AccessKey credentials, VM name, image name, L3 network
name, and instance offering name in `terraform.tfvars`. Leave `static_ip` at its
default `null` value to let Terraform treat the argument as unset and allow
ZStack to allocate the NIC address.

The example includes `default_l3` and `static_ip` in `network_interfaces` to
show the explicit form. Both are optional fields: omit `default_l3` for a simple
single-NIC VM unless you need to mark a default NIC, and omit `static_ip` unless
a fixed address is required.

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

Run `terraform destroy` when the VM is no longer needed.
