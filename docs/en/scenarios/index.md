# Scenario Examples

This section explains runnable Terraform examples under `examples/common` by
real customer scenario. Larger production shapes are listed in
[Production Examples](production-examples.md). For step-by-step learning paths,
see [Practice Tutorials](practice-tutorials.md).

## Common Scenarios

| Scenario | Example |
|---|---|
| Provider authentication | [examples/common/01-provider](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider) |
| Query existing resources | [examples/common/02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources) |
| Create one VM | [examples/common/03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm) |
| Create multiple VMs | [examples/common/04-create-10-vms](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms) |
| VIP/EIP | [examples/common/05-eip](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip) |
| VM + security group | [examples/common/06-security-group](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group) |
| Basic VPC network | [examples/common/07-vpc](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/07-vpc) |
| VM + data volume | [examples/common/08-volume](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume) |
| Image query/management | [examples/common/09-image-query-management](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/09-image-query-management) |
| Import existing VM | [examples/common/10-import-existing-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/10-import-existing-vm) |
| Web load balancing | [examples/common/11-load-balancer-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web) |
| VPC routing | [examples/common/12-vpc-routing](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing) |
| VM initialization scripts | [examples/common/13-vm-init-scripts](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/13-vm-init-scripts) |
| Tag management | [examples/common/14-tags](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/14-tags) |
| IAM and AccessKey | [examples/common/15-iam-access-key](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key) |
| Monitoring notification | [examples/common/16-monitoring-notification](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification) |
| Scheduler | [examples/common/17-scheduler](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/17-scheduler) |
| Global Config | [examples/common/18-global-config](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config) |
| License | [examples/common/19-license](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/19-license) |
| Backup / CDP | [examples/common/20-backup-cdp](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp) |
| Network Observability | [examples/common/21-network-observability](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/21-network-observability) |
| Advanced Network | [examples/common/22-advanced-network](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/22-advanced-network) |

Each example directory contains `main.tf`, `variables.tf`,
`terraform.tfvars.example`, and `README.md`. Before running, copy the variable
file and replace placeholders with real resource names or UUIDs from the target
ZStack environment.
