# Production Examples

Production examples live under `examples/production`. They demonstrate
Terraform project structure, resource boundaries, and delivery constraints.
They are references, not complete production modules.

Run `examples/common/02-query-existing-resources` first to confirm candidate
images, L3 networks, offerings, disk offerings, and public L3 networks in the
target ZStack environment.

| Example | Directory | Purpose |
|---|---|---|
| Three-tier web infrastructure | `examples/production/three-tier-web` | Creates web/app VMs, data volumes, security groups, VIP/LB, and standard tags |
| Kubernetes infrastructure reference | `examples/production/k8s-reference` | Creates control-plane/worker VMs, API LB, and node security group without installing Kubernetes |
| Existing VM fleet import | `examples/production/import-vm-fleet` | Imports existing VMs in reviewed batches and drives the plan toward no-op |
| Automation IAM | `examples/production/automation-iam` | Creates automation account, IAM2 project, virtual ID, and AccessKey |

## Boundaries

- Production use should add a remote backend and state access controls.
- Credentials, AccessKey secrets, Kubernetes tokens, certificates, and private
  keys must come from a secret store.
- CIDRs, offerings, images, and network names must be confirmed in the target
  environment.
- After importing existing resources, iterate on `terraform plan` until the
  result is no-op or only contains accepted changes.
- If the plan shows replacement, stop and confirm immutable fields before
  applying.

## Suggested Validation Order

1. `three-tier-web`: validate VM, volume, security group, VIP/LB, and tag
   composition.
2. `automation-iam`: validate provider `1.1.3` AccessKey `user_uuid` behavior.
3. `import-vm-fleet`: rehearse import with dedicated test VMs.
4. `k8s-reference`: plan first, confirm node sizing and API entry design, then
   hand off to the Kubernetes installation workflow.
