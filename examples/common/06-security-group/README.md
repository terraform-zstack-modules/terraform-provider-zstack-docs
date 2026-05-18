# 06-security-group

Creates a VM, a security group, security group rules, and attaches the group to
the VM NIC.

This example uses:

- `zstack_networking_secgroup`
- `zstack_networking_secgroup_rule`
- `zstack_networking_secgroup_attachment`

## Inputs

Edit `terraform.tfvars` with the image, L3 network, instance offering, allowed
CIDR, protocol, and port range. This example rejects `0.0.0.0/0` for ingress
CIDRs; use an explicit trusted CIDR such as a bastion, office, or application
network. Keep rule intent explicit for review.

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

Run `terraform destroy` when the VM, rules, and attachment should be removed.
