# Examples

Runnable Terraform examples are kept in the repository root under
`examples/common` and `examples/production`. They are shared by all language
versions of the documentation.

## Common Examples

| Directory | Scenario |
|---|---|
| [`examples/common/01-provider`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider) | Provider and AccessKey authentication |
| [`examples/common/02-query-existing-resources`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources) | Query existing images, networks, offerings, zones, clusters, and hosts |
| [`examples/common/03-create-vm`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm) | Create one VM with `network_interfaces` |
| [`examples/common/04-create-10-vms`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms) | Create multiple VMs with stable `for_each` keys |
| [`examples/common/05-eip`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip) | Create VIP and bind EIP to a VM NIC |
| [`examples/common/06-security-group`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group) | Create VM, security group, rules, and attachment |
| [`examples/common/07-vpc`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/07-vpc) | Create a basic VPC network |
| [`examples/common/08-volume`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume) | Create VM and attach data volume |
| [`examples/common/09-image-query-management`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/09-image-query-management) | Query existing image and optionally create a managed image |
| [`examples/common/10-import-existing-vm`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/10-import-existing-vm) | Import an existing VM into Terraform state |
| [`examples/common/11-load-balancer-web`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web) | Create VIP, load balancer, listener, and server group |
| [`examples/common/12-vpc-routing`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing) | Create VPC network and route table entries |
| [`examples/common/13-vm-init-scripts`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/13-vm-init-scripts) | Create VM, SSH key, instance script, and script execution |
| [`examples/common/14-tags`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/14-tags) | Create and attach tags |
| [`examples/common/15-iam-access-key`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key) | Create account, IAM2 objects, and AccessKey |
| [`examples/common/16-monitoring-notification`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification) | Create alarm and notification primitives |
| [`examples/common/17-scheduler`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/17-scheduler) | Create scheduler job and trigger |
| [`examples/common/18-global-config`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config) | Query and optionally manage global config |
| [`examples/common/19-license`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/19-license) | Query license capacity/nodes and optionally upload license |
| [`examples/common/20-backup-cdp`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp) | Create CDP and backup resources |
| [`examples/common/21-network-observability`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/21-network-observability) | Create flow and port mirror observability resources |
| [`examples/common/22-advanced-network`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/22-advanced-network) | Create IPsec and policy route resources |

Each directory contains `main.tf`, `variables.tf`, `terraform.tfvars.example`,
and `README.md`.

## Production Examples

| Directory | Scenario |
|---|---|
| [`examples/production/three-tier-web`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/three-tier-web) | Three-tier web infrastructure reference |
| [`examples/production/k8s-reference`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/k8s-reference) | Kubernetes infrastructure reference |
| [`examples/production/import-vm-fleet`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/import-vm-fleet) | Existing VM fleet import workflow |
| [`examples/production/automation-iam`](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/automation-iam) | Automation IAM and AccessKey reference |

## Provider Version Policy

All published examples should use the same provider source and version policy.
Public examples use `ZStack-Robot/zstack` and currently pin provider version
`1.1.3`. Private-registry examples must use the exact source string shown by the
customer's ZStack platform or provider mirror.

When upgrading examples, update the provider constraint consistently, run
`terraform init -upgrade`, and verify `terraform plan` for every scenario that
will be published. Any unverified provider version should be handled as
migration work.

## Example Quality Rules

All new variables must include a `description`; sensitive inputs must also set
`sensitive = true`. Examples should remain runnable teaching material, so avoid
hard-coded customer UUIDs, credentials, or environment-specific names.
