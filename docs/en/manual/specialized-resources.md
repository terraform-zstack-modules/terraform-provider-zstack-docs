# Specialized Resources

Specialized resources are for industry, hardware, or integration scenarios. They
usually depend on specific environments, external systems, or hardware devices,
and should not be reused directly as general getting-started examples.

Before using these resources, confirm the target environment, resource
dependencies, creation order, cleanup method, and rollback strategy. Without
real environment validation, documentation should provide only resource indexes
and risk notes.

## Baremetal

Use cases: baremetal resource management, PXE boot, and baremetal instance
delivery.

Resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_baremetal_chassis` | resource | Manage baremetal chassis or physical server onboarding objects. |
| `zstack_baremetal_instance` | resource | Manage baremetal instance lifecycle. |
| `zstack_baremetal_pxe_server` | resource | Manage baremetal PXE boot service. |

Notes:

- Requires a real baremetal environment and network boot configuration.
- PXE, chassis, and instance resources have strong dependencies. Do not invent
  UUIDs.
- Start with read-only queries and single-resource import when possible.

## External And Hybrid Cloud

Use cases: external virtualization platform onboarding, hybrid cloud, or Alibaba
Cloud proxy resources.

Resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vcenter` | resource | Manage vCenter resources connected to ZStack. |
| `zstack_aliyun_proxy_vpc` | resource | Manage Alibaba Cloud VPC proxy objects on the ZStack side. |
| `zstack_aliyun_proxy_vswitch` | resource | Manage Alibaba Cloud vSwitch proxy objects on the ZStack side. |
| `zstack_aliyun_nas_access_group` | resource | Manage Alibaba Cloud NAS access group related configuration. |

Notes:

- Requires external platform accounts, network reachability, and authorization.
- Terraform manages ZStack-side resources; external cloud state may still need
  validation with external tools.
- Do not place real cloud accounts, AK/SK, or network addresses in generic
  examples.

## Security Machines

Use cases: connecting industry security devices, cryptographic appliances, or
dedicated security capabilities.

Resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_jit_security_machine` | resource | Manage JIT security machine onboarding objects. |
| `zstack_san_sec_security_machine` | resource | Manage SAN_SEC security machine onboarding objects. |
| `zstack_info_sec_security_machine` | resource | Manage information security machine onboarding objects. |
| `zstack_fi_sec_security_machine` | resource | Manage FI_SEC security machine onboarding objects. |
| `zstack_flk_sec_security_machine` | resource | Manage FLK_SEC security machine onboarding objects. |

Notes:

- Strongly depends on vendor devices, certificates, networks, and security
  policy.
- Changes require security team approval.
- Examples should use only placeholder variables and must not contain real
  device addresses or credentials.

## Storage Hardware

Use cases: connecting and managing specialized storage resources.

Resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_iscsi_server` | resource | Manage iSCSI storage server onboarding objects. |
| `zstack_nvme_server` | resource | Manage NVMe storage server onboarding objects. |
| `zstack_ceph_pool` | resource | Manage Ceph pools. |
| `zstack_ceph_primary_storage` | resource | Manage Ceph primary storage for VM root/data volumes. |
| `zstack_ceph_backup_storage` | resource | Manage Ceph image/backup storage for images and backup data. |

Notes:

- Requires a real storage cluster, network, and authentication information.
- Ceph pool, primary storage, and backup storage lifecycle and capacity impact
  are significant.
- Confirm whether business data already exists before production use.

## Other Platform Resources

Use cases: platform auxiliary capabilities, logs, billing, datasets, container
endpoints, and related platform resources.

Resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_directory` | resource | Manage platform directory objects. |
| `zstack_dataset` | resource | Manage dataset objects, commonly used in data or AI scenarios. |
| `zstack_price_table` | resource | Manage price tables, affecting the billing model. |
| `zstack_email_media` | resource | Manage email media configuration for notification delivery. |
| `zstack_log_server` | resource | Manage external log server integration. |
| `zstack_snmp_agent` | resource | Manage SNMP agent integration. |
| `zstack_container_management_endpoint` | resource | Manage container platform endpoint integration. |

Notes:

- `zstack_price_table` affects the billing model and requires approval.
- `zstack_log_server` and `zstack_snmp_agent` depend on external operations
  systems.
- `zstack_container_management_endpoint` depends on container platform
  connection information.
- `zstack_dataset` is suitable for AI/data scenarios and requires confirming
  data lifecycle and permissions.

## Pre-Use Checklist

Before writing runnable examples or managing specialized resources in
production, confirm at least:

- A real environment is available for validation.
- Provider docs, examples, or tests cover the key lifecycle.
- Resource dependencies, creation order, cleanup method, and rollback strategy
  are clear.
- Missing UUIDs, device addresses, credentials, or external-system details are
  represented as variables.
- Examples that have not been validated in a real environment are not marked as
  production-ready.
