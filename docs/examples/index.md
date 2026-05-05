# Examples

Runnable Terraform examples are kept in the repository root under
`examples/common`. They are shared by all language versions of the documentation.

## Common Examples

| Directory | Scenario |
|---|---|
| `examples/common/01-provider` | Provider and AccessKey authentication |
| `examples/common/02-query-existing-resources` | Query existing images, networks, offerings, zones, clusters, and hosts |
| `examples/common/03-create-vm` | Create one VM with `network_interfaces` |
| `examples/common/04-create-10-vms` | Create multiple VMs with stable `for_each` keys |
| `examples/common/05-eip` | Create VIP and bind EIP to a VM NIC |
| `examples/common/06-security-group` | Create VM, security group, rules, and attachment |
| `examples/common/07-vpc` | Create a basic VPC network |
| `examples/common/08-volume` | Create VM and attach data volume |
| `examples/common/09-image-query-management` | Query existing image and optionally create a managed image |
| `examples/common/10-import-existing-vm` | Import an existing VM into Terraform state |
| `examples/common/11-load-balancer-web` | Create VIP, load balancer, listener, and server group |
| `examples/common/12-vpc-routing` | Create VPC network and route table entries |
| `examples/common/13-vm-init-scripts` | Create VM, SSH key, instance script, and script execution |
| `examples/common/14-tags` | Create and attach tags |
| `examples/common/15-iam-access-key` | Create account, IAM2 objects, and AccessKey |
| `examples/common/16-monitoring-notification` | Create alarm and notification primitives |
| `examples/common/17-scheduler` | Create scheduler job and trigger |
| `examples/common/18-global-config` | Query and optionally manage global config |
| `examples/common/19-license` | Query license capacity/nodes and optionally upload license |
| `examples/common/20-backup-cdp` | Create CDP and backup resources |
| `examples/common/21-network-observability` | Create flow and port mirror observability resources |
| `examples/common/22-advanced-network` | Create IPsec and policy route resources |
| `examples/common/23-resource-stack` | Create stack and preconfiguration templates |

Each directory contains `main.tf`, `variables.tf`, `terraform.tfvars.example`,
and `README.md`.

## Provider Version Policy

All published examples should use the same provider source and version policy.
Public examples use `ZStack-Robot/zstack` and currently pin provider version
`1.1.2`. Private-registry examples must use the exact source string shown by the
customer's ZStack platform or provider mirror.

When upgrading examples, update the provider constraint consistently, run
`terraform init -upgrade`, and verify `terraform plan` for every scenario that
will be published. Any unverified provider version should be handled as
migration work.

## Example Quality Rules

All new variables must include a `description`; sensitive inputs must also set
`sensitive = true`. Examples should remain runnable teaching material, so avoid
hard-coded customer UUIDs, credentials, or environment-specific names.
