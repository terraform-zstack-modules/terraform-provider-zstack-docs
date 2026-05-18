# Specialized Resources

Specialized resources are indexed first. They should be expanded only when a
customer scenario and environment are available.

## Baremetal

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_baremetal_chassis` | resource | Manage a baremetal chassis or physical server access object. |
| `zstack_baremetal_instance` | resource | Manage a baremetal instance lifecycle. |
| `zstack_baremetal_pxe_server` | resource | Manage a baremetal PXE boot service. |

Requires a real baremetal environment.

## External And Hybrid

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vcenter` | resource | Manage a vCenter integration in ZStack. |
| `zstack_aliyun_proxy_vpc` | resource | Manage an Aliyun proxy VPC object on the ZStack side. |
| `zstack_aliyun_proxy_vswitch` | resource | Manage an Aliyun proxy vSwitch object on the ZStack side. |
| `zstack_aliyun_nas_access_group` | resource | Manage Aliyun NAS access group configuration. |

Requires customer-specific external systems.

## Security Machines

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_jit_security_machine` | resource | Manage a JIT security machine integration. |
| `zstack_san_sec_security_machine` | resource | Manage a SAN_SEC security machine integration. |
| `zstack_info_sec_security_machine` | resource | Manage an information security machine integration. |
| `zstack_fi_sec_security_machine` | resource | Manage an FI_SEC security machine integration. |
| `zstack_flk_sec_security_machine` | resource | Manage an FLK_SEC security machine integration. |

Requires security device context and lifecycle rules.

## Storage Hardware

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_iscsi_server` | resource | Manage an iSCSI storage server integration. |
| `zstack_nvme_server` | resource | Manage an NVMe storage server integration. |
| `zstack_ceph_pool` | resource | Manage a Ceph pool. |
| `zstack_ceph_primary_storage` | resource | Manage Ceph primary storage for VM root/data volumes. |
| `zstack_ceph_backup_storage` | resource | Manage Ceph image/backup storage for images and backup data. |

Requires real storage hardware or storage cluster details.

## Other Platform Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_directory` | resource | Manage platform directory objects. |
| `zstack_dataset` | resource | Manage dataset objects, often used in data or AI-related scenarios. |
| `zstack_price_table` | resource | Manage price tables that affect billing models. |
| `zstack_email_media` | resource | Manage email media configuration for notifications. |
| `zstack_log_server` | resource | Manage external log server integration. |
| `zstack_snmp_agent` | resource | Manage SNMP agent integration. |
| `zstack_container_management_endpoint` | resource | Manage a container platform integration endpoint. |
