# Specialized Resources

Specialized resources are indexed first. They should be expanded only when a
customer scenario and environment are available.

## Baremetal

- `zstack_baremetal_chassis`
- `zstack_baremetal_instance`
- `zstack_baremetal_pxe_server`

Requires a real baremetal environment.

## External And Hybrid

- `zstack_vcenter`
- `zstack_aliyun_proxy_vpc`
- `zstack_aliyun_proxy_vswitch`
- `zstack_aliyun_nas_access_group`

Requires customer-specific external systems.

## Security Machines

- `zstack_jit_security_machine`
- `zstack_san_sec_security_machine`
- `zstack_info_sec_security_machine`
- `zstack_fi_sec_security_machine`
- `zstack_flk_sec_security_machine`

Requires security device context and lifecycle rules.

## Storage Hardware

- `zstack_iscsi_server`
- `zstack_nvme_server`
- `zstack_ceph_pool`
- `zstack_ceph_primary_storage`
- `zstack_ceph_backup_storage`

Requires real storage hardware or storage cluster details.

## Other Platform Resources

Directory, dataset, price table, email media, log server, SNMP agent, and
container management endpoint resources should be documented after the customer
scenario is confirmed.
