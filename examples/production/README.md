# Production Examples

Production examples show how to organize Terraform for realistic customer
delivery patterns. They are references, not complete production modules.

Use `examples/common/02-query-existing-resources` before running these examples
so image, network, offering, and storage inputs come from the target ZStack
environment.

| Directory | Scenario |
|---|---|
| `three-tier-web` | Web/application infrastructure with LB, security groups, volumes, and tags |
| `k8s-reference` | Kubernetes node infrastructure reference without Kubernetes installation |
| `import-vm-fleet` | Import existing VMs into Terraform state in reviewed batches |
| `automation-iam` | Dedicated automation account, IAM2 objects, and AccessKey |

Production use should add remote backend configuration, approvals, naming
standards, variable validation, and secret-store integration.
