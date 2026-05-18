# Practice Tutorials

This page organizes `examples/common` and `examples/production` into executable
learning paths. Each path queries existing resources before creating dependent
resources.

## Beginner Path: Create One VM

| Step | Example | Goal |
|---|---|---|
| 1 | [01-provider](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider) | Validate authentication and provider initialization |
| 2 | [02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources) | Find image, L3 network, and offering |
| 3 | [03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm) | Create a VM and output UUIDs |
| 4 | [06-security-group](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group) | Attach a security group to the VM NIC |

Acceptance criteria: `terraform plan` is explainable, VM UUID and NIC UUID are
output, and security group CIDR comes from a trusted source.

## Network Entry Path: VIP, EIP, And LB

| Step | Example | Goal |
|---|---|---|
| 1 | [05-eip](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip) | Create a VIP and bind EIP |
| 2 | [11-load-balancer-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web) | Create load balancer, listener, and server group |
| 3 | [12-vpc-routing](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing) | Validate VPC routing modeling |

Acceptance criteria: VIP, LB, listener, and server group UUIDs are traceable,
and ports and CIDRs have been reviewed.

## Storage And Image Path

| Step | Example | Goal |
|---|---|---|
| 1 | [08-volume](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume) | Create and attach a data volume |
| 2 | [09-image-query-management](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/09-image-query-management) | Query images and optionally create a managed image |
| 3 | [20-backup-cdp](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp) | Understand backup/CDP environment dependencies |

Acceptance criteria: disk offering, backup storage, and business retention policy
come from the real environment.

## Platform Governance Path

| Step | Example | Goal |
|---|---|---|
| 1 | [14-tags](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/14-tags) | Establish standard tags |
| 2 | [15-iam-access-key](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key) | Create automation identity and AccessKey |
| 3 | [16-monitoring-notification](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification) | Configure alarm and notification primitives |
| 4 | [18-global-config](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config) | Query or manage global config in a controlled way |

Acceptance criteria: permission boundary, sensitive outputs, and admin change
approval are explicit.

## Production Reference Path

| Goal | Example |
|---|---|
| Three-tier web infrastructure | [examples/production/three-tier-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/three-tier-web) |
| Kubernetes infrastructure reference | [examples/production/k8s-reference](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/k8s-reference) |
| Existing VM fleet import | [examples/production/import-vm-fleet](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/import-vm-fleet) |
| Automation IAM | [examples/production/automation-iam](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/automation-iam) |

Production examples demonstrate project organization. They are not complete
customer production modules. Read the [Production Guide](../manual/production-guide.md)
before formal use.
