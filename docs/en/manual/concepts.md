# Terraform And ZStack Concepts

This page maps Terraform terminology to ZStack resources. It explains why
examples query existing resources before creating dependent resources.

## Terraform Concepts

| Concept | Description |
|---|---|
| Provider | The Terraform plugin that calls ZStack APIs. This manual uses `ZStack-Robot/zstack` |
| Resource | A ZStack object Terraform creates, updates, or deletes, such as VM, volume, or security group |
| Data source | A query for an existing ZStack object; it does not create resources |
| State | Terraform's mapping between Terraform addresses and ZStack UUIDs |
| Plan | The proposed diff after Terraform compares HCL, state, and remote objects |
| Variable | External input such as management node address, image name, or network UUID |
| Output | Value exposed for review or downstream workflows, such as VM UUID, NIC UUID, or VIP address |
| Import | Binding an existing ZStack resource into Terraform state |

## ZStack Resource Mapping

| ZStack object | Common Terraform use |
|---|---|
| Zone, cluster, host | Usually queried as data sources to locate existing compute resources |
| Image | VM creation input; image chapters can query or create images |
| Backup storage | Image/backup storage used by images, image import, and some backup/CDP workflows |
| Instance offering | VM size; `cpu_num` and `memory_size` can be used instead |
| Disk offering | Data volume size profile |
| L2 network | Layer-2 network foundation, usually prepared by platform administrators |
| L3 network | Network foundation for VM NICs, VIP, EIP, and VPC networks |
| VPC / virtual router | Carrier for VPC networking and routing capabilities |
| VIP / EIP | External entry address and public access binding |
| Security group | Access control rule set attached to VM NICs |
| Volume | Data disk; model separately when it needs an independent lifecycle |
| Account, user, IAM2, AccessKey | Automation identity and permission boundary |
| Global config, license, scheduler | Administrator-level resources that require change review before production apply |

## Identity Field Selection

- Prefer `uuid` for automation and CI/CD.
- Use exact `name` only when the name is unique.
- Use `name_pattern` only for discovery, then output and review matches.
- Do not invent UUIDs, metric names, job types, route targets, or external
  system addresses in examples.

## Resource Dependencies

Terraform builds dependencies from expression references, such as a VM referring
to image UUID, L3 network UUID, and offering UUID. Use explicit dependencies
only when the dependency cannot be represented through references.

Common order:

1. Query image, network, and offering.
2. Create the VM.
3. Create and attach security group, volume, VIP/EIP, or load balancer.
4. Output UUIDs and addresses for diagnostics or downstream integration.
