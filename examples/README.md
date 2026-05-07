# Examples

`examples/common` contains focused runnable Terraform examples shared by all language versions of the documentation.
`examples/production` contains larger production reference examples.

Localized documentation should explain these examples from `docs/zh` and `docs/en` instead of duplicating Terraform code.

## Provider Version Policy

Public examples use `ZStack-Robot/zstack` and currently pin provider version
`1.1.3`. Private-registry examples must use the exact source string shown by the
customer's ZStack platform or provider mirror.

When upgrading examples, update the provider constraint consistently, run
`terraform init -upgrade`, and verify `terraform plan` for every scenario that
will be published or demonstrated. Any unverified provider version should be
handled as migration work.

## Quality Rules

All new variables must include a `description`; sensitive inputs must also set
`sensitive = true`. Examples should avoid hard-coded customer UUIDs,
credentials, or environment-specific names.

## Common Examples

| Directory | Scenario |
|---|---|
| `01-provider` | Provider and AccessKey authentication |
| `02-query-existing-resources` | Query existing images, networks, offerings, zones, clusters, and hosts |
| `03-create-vm` | Create one VM with `network_interfaces` |
| `04-create-10-vms` | Create multiple VMs with stable `for_each` keys |
| `05-eip` | Allocate VIP and bind EIP to a VM NIC |
| `06-security-group` | Create VM, security group, rules, and attachment |
| `07-vpc` | Create a basic VPC network |
| `08-volume` | Create VM and attach data volume |
| `09-image-query-management` | Query existing image and optionally create a managed image |
| `10-import-existing-vm` | Import an existing VM into Terraform state |
| `11-load-balancer-web` | Create VIP, load balancer, listener, and server group |
| `12-vpc-routing` | Create VPC network and route table entries |
| `13-vm-init-scripts` | Create VM, SSH key, instance script, and script execution |
| `14-tags` | Create and attach tags |
| `15-iam-access-key` | Create account, IAM2 objects, and AccessKey |
| `16-monitoring-notification` | Create alarm and notification primitives |
| `17-scheduler` | Create scheduler job and trigger |
| `18-global-config` | Query and optionally manage global config |
| `19-license` | Query license capacity/nodes and optionally upload license |
| `20-backup-cdp` | Create CDP and backup resources |
| `21-network-observability` | Create flow and port mirror observability resources |
| `22-advanced-network` | Create IPsec and policy route resources |

## Production Examples

| Directory | Scenario |
|---|---|
| `three-tier-web` | Web/application infrastructure with LB, security groups, volumes, and tags |
| `k8s-reference` | Kubernetes node infrastructure reference without Kubernetes installation |
| `import-vm-fleet` | Import existing VMs into Terraform state in reviewed batches |
| `automation-iam` | Dedicated automation account, IAM2 objects, and AccessKey |
