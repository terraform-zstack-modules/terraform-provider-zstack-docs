# 05-eip

Allocates a VIP and binds an EIP to an existing VM NIC.

Use this after creating or selecting a VM. The example looks up the public L3
network and target VM with data sources, then binds the EIP to the selected VM
NIC. Narrow `public_l3_network_name_pattern` and set `target_vm_name` before
applying if the broad defaults match more than one candidate.

## Inputs

Set the public L3 network pattern and target VM name in `terraform.tfvars`.
Confirm the selected VM NIC and public L3 network before applying.

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

Run `terraform destroy` to remove the EIP and VIP created by this example.
