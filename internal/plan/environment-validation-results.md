# Environment Validation Results

This file records real-environment validation runs for the docs examples.

## 2026-05-06

Environment:

- Provider: `ZStack-Robot/zstack` `1.1.2`
- Terraform execution: root `.env` supplied only ZStack auth variables.
- Provider installation: local filesystem mirror at
  `/private/tmp/zstack-provider-mirror.tfrc`, because registry downloads were
  intermittent in the test runner.
- Terraform provider IPC: commands had to run outside the Codex filesystem
  sandbox; inside the sandbox the provider could not bind its Unix socket under
  `/var/folders/.../T/plugin*`.

Observed reusable candidates:

- Zone: `zone-1`
- Clusters: `cluster-1`, `test-cluster-gemini`
- Host: `host-1`
- Public L3: `l3-public`
- Private L3: `l3-private-1`, `l3-private-2`
- Instance offerings: `small-vm`, `medium-vm`
- Disk offerings: `small-disk-1GB`, `medium-disk-10GB`,
  `large-disk-50GB`, `monkey-disk-offering-edited`
- Image: `zstack-image`
- Backup storage discovered for P2: `sftp-bs`
- vRouter discovered for VPC/advanced network tests:
  `vrouter.l3.l3-private-1.b8f1c1`

### P0 Core

| Example | Level reached | Result | Notes |
|---|---|---|---|
| `01-provider` | `init` / `validate` / `plan` | Pass | Provider initialized and authenticated. |
| `02-query-existing-resources` | `init` / `validate` / `plan` | Pass | Broad discovery data sources returned zones, clusters, hosts, images, L3 networks, offerings, and disk offerings. |
| `03-create-vm` | `init` / `validate` / `plan` / `apply` / no-op `plan` / `destroy` | Pass | Created and destroyed disposable VM `tf-p0-vm`. |
| `04-create-10-vms` | `init` / `validate` / `plan` / `apply` / no-op `plan` / `destroy` | Pass | Created and destroyed 10 VMs `tf-p0-batch-01` through `tf-p0-batch-10`. |
| `06-security-group` | `init` / `validate` / `plan` / partial `apply` / cleanup | Blocked | `0.0.0.0/0` ingress was rejected by ZStack with `SG.1006`; after changing the example to narrower CIDR and rule priorities `1/2`, SG and VM were created but `zstack_networking_secgroup_attachment` failed with `Get: key not found`. Imported and destroyed leftover VM/SG. |
| `08-volume` | `init` / `validate` / `plan` / `apply` / no-op `plan` / `destroy` | Pass | Created VM `tf-p0-volume` and data volume `tf-p0-data-volume`, then destroyed both. |
| `09-image-query-management` | `init` / `validate` / `plan` | Pass | Query-only path passed with `existing_image_name=zstack-image`; image upload path was not applied. |
| `10-import-existing-vm` | create source VM / `import` / no-op `plan` / cleanup | Pass | Created disposable VM `tf-p0-import-source`, imported it with the import block, verified no-op plan, then destroyed the source VM. |

### P1 Common Production Scenarios

| Example | Level reached | Result | Notes |
|---|---|---|---|
| `05-eip` | `init` / `validate` / `plan` / `apply` / no-op `plan` / `destroy` | Pass | Created target VM `tf-p1-eip-target`, VIP/EIP binding, then destroyed all resources. |
| `07-vpc` | `init` / `validate` / `plan` / partial `apply` / cleanup | Blocked | VPC creation succeeded enough to enter state, but attaching to existing vRouter failed with ZStack `SYS.1006`: VIP for the selected vRouter already has service provider `VirtualRouter`. Destroy cleaned up `tf-p1-vpc`. |
| `11-load-balancer-web` | `init` / `validate` / `plan` / `apply` / no-op `plan` / `destroy` | Pass | Created and destroyed VIP, LB, listener, and server group on `l3-public`. |
| `12-vpc-routing` | `init` / `validate` / `plan` | Pass / not applied | Plan produced VPC, route table, and route entry. Not applied because it shares the VPC attach path that failed in `07-vpc`. |
| `13-vm-init-scripts` | `init` / `validate` / `plan` / partial `apply` / cleanup | Blocked | VM, SSH key, and script resource were created; script execution failed because QGA was not running in the selected image. Destroy cleaned up all created resources. |
| `14-tags` | `init` / `validate` / `plan` / partial `apply` / cleanup | Blocked | Tag was created, but `zstack_tag_attachment` failed with `Get: key not found`. Imported and destroyed leftover tag `tf-p1-environment`. |
| `15-iam-access-key` | `init` / `validate` / `plan` / partial `apply` / cleanup | Blocked | Account, IAM2 project, and virtual ID were created; AccessKey creation failed because API/provider request lacked mandatory `userUuid`. Destroy cleaned up created IAM resources. |
| `16-monitoring-notification` | `init` / `validate` / `plan` / partial `apply` / cleanup | Blocked | SNS topic and webhook were created; SNS email endpoint failed with `id to load is required for loading`, and alarm failed with internal ZStack error. Destroy cleaned up topic/webhook. |

### P2 Admin And Advanced Scenarios

| Example | Level reached | Result | Notes |
|---|---|---|---|
| `17-scheduler` | `init` / `validate` / `plan` | Pass / not applied | Plan creates scheduler job and cron trigger. Not applied because job type and target resource action require administrator confirmation. |
| `18-global-config` | `init` / `validate` / `plan` | Pass | Query-only plan read `vm/deletionPolicy = Delay`; `manage_global_config=false`, no infrastructure changes. |
| `19-license` | `init` / `validate` / `plan` | Pass after example fix | Initial `name_pattern="%"` query failed because this environment's `LicenseAuthorizedNodeInventory` is not queryable by `name`. Default was changed to `null`; capacity and nodes then queried successfully. |
| `20-backup-cdp` | `init` / `validate` / `plan` | Pass / not applied | Plan used discovered `sftp-bs` and an existing data volume. Not applied because CDP/volume backup semantics depend on backup storage type and backup policy approval. |
| `21-network-observability` | `init` / `validate` / `plan` | Pass / not applied | Plan passed with documentation-only collector IPs and discovered network UUID. Not applied because no real collector/mirror endpoint contract was provided. |
| `22-advanced-network` | `init` / `validate` / `plan` | Pass / not applied | Plan passed with discovered VIP/vRouter and placeholder route table UUID. First plan showed `protocol` must be uppercase; docs now state `TCP`/`UDP`/`ICMP`. Not applied because IPsec peer and route table are external dependencies. |

### Follow-Up Items

- Provider/resource issues to escalate or reproduce minimally:
  `zstack_networking_secgroup_attachment`, `zstack_tag_attachment`,
  `zstack_access_key`, `zstack_sns_email_endpoint`, `zstack_alarm`,
  and security group rule priority readback.
- Environment constraints to document:
  selected image does not run QGA, selected vRouter/VIP combination cannot
  accept the VPC attach flow, and backup/observability/IPsec scenarios need
  explicit external systems before apply.
- Documentation/example fixes already made from this run:
  auth-only root `.env`, data-source-first discovery, `06-security-group`
  CIDR/priority defaults, `19-license` default `node_name_pattern = null`,
  and uppercase protocol guidance for `22-advanced-network`.

## 2026-05-06 Provider 1.1.3 Retest

Provider `ZStack-Robot/zstack` `1.1.3` was installed from the public Terraform
Registry and retested against the previous bug candidates.

| Example | Level reached | Result | Notes |
|---|---|---|---|
| `01-provider` | `init -upgrade` / `validate` / `plan` | Pass | Provider `1.1.3` installed and authenticated successfully. |
| `06-security-group` | `init -upgrade` / `validate` / `plan` / `apply` / `plan` / `destroy` | Mostly pass | `zstack_networking_secgroup_attachment` no longer fails with `Get: key not found`; create and destroy completed. Post-apply plan still showed rule priority drift: requested HTTP priority `2`, remote state returned `3`. |
| `14-tags` | `init -upgrade` / `validate` / `plan` / `apply` / no-op `plan` / `destroy` | Pass | `zstack_tag_attachment` no longer fails with `Get: key not found`. |
| `15-iam-access-key` | `validate` / `plan` / `apply` / no-op `plan` / `destroy` | Pass after example update | Provider `1.1.3` requires `user_uuid`; setting `user_uuid = zstack_account.automation.uuid` created and destroyed the AccessKey successfully. |
| `16-monitoring-notification` | `init -upgrade` / `validate` / targeted `plan` / targeted `apply` | Blocked | `zstack_sns_email_endpoint` now requires `platform_uuid`; provider exposes no SNS platform data source, so full example needs external input. Targeted `zstack_alarm` apply still failed with ZStack internal error `SYS.1000`. |
| `19-license` | `init -upgrade` / `validate` / `plan` | Pass after example update | `zstack_license_authorized_nodes` no longer supports `name_pattern`; removing the argument produced a successful read-only plan. |

Retest conclusion:

- Fixed in provider `1.1.3`: security group attachment, tag attachment,
  and AccessKey creation when `user_uuid` is supplied.
- Still needs follow-up: `zstack_alarm` still returns the same ZStack internal
  error in this environment; SNS email endpoints now need an explicit
  `platform_uuid`; security group rule priority readback is not idempotent for
  the tested HTTP rule.

Resource orchestration and orchestration templates were later confirmed
canceled and removed from the current documentation and example scope.
