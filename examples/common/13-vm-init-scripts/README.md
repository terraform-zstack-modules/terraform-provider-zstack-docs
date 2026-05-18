# 13-vm-init-scripts

Creates an SSH key pair, a VM, an instance script, and a script execution record.

Use this scenario for day-1 initialization tasks such as installing packages,
configuring agents, or running bootstrap scripts.

## Inputs

Set the image, L3 network, instance offering, SSH key, script content, and script
execution timeout in `terraform.tfvars`. Do not put long-lived secrets in script
content.

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

Run `terraform destroy` when the VM, key pair, and script resources are no
longer needed.
