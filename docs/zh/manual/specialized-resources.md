# Specialized Resources

P3 资源面向专项、行业、硬件或集成场景。它们通常依赖特定环境、外部系统或硬件设备，不适合作为第一版通用客户 examples 深写。

第一阶段只做索引和风险提示。后续应在出现明确客户场景后，再补充可运行 examples、拓扑图和排障路径。

## Baremetal

适用场景：裸金属资源纳管、PXE 启动、裸金属实例交付。

资源：

- `zstack_baremetal_chassis`
- `zstack_baremetal_instance`
- `zstack_baremetal_pxe_server`

注意事项：

- 需要真实裸金属环境和网络启动配置。
- PXE、机箱、实例之间存在强依赖，不能凭空生成 UUID。
- 建议先从只读查询和单资源导入开始。

## External / Hybrid

适用场景：外部虚拟化平台接入、混合云或阿里云代理资源。

资源：

- `zstack_vcenter`
- `zstack_aliyun_proxy_vpc`
- `zstack_aliyun_proxy_vswitch`
- `zstack_aliyun_nas_access_group`

注意事项：

- 需要外部平台账号、网络连通性和授权。
- Terraform 管理的是 ZStack 侧资源，外部云侧状态可能还需要外部工具验证。
- 不应在通用 examples 中写真实云账号、AK/SK 或网络地址。

## Security Machines

适用场景：对接行业安全设备、加密机或专用安全能力。

资源：

- `zstack_jit_security_machine`
- `zstack_san_sec_security_machine`
- `zstack_info_sec_security_machine`
- `zstack_fi_sec_security_machine`
- `zstack_flk_sec_security_machine`

注意事项：

- 强依赖厂商设备、证书、网络和安全策略。
- 变更前需要安全团队审批。
- examples 应只使用占位变量，不应包含真实设备地址或凭证。

## Storage Hardware

适用场景：接入和管理专项存储资源。

资源：

- `zstack_iscsi_server`
- `zstack_nvme_server`
- `zstack_ceph_pool`
- `zstack_ceph_primary_storage`
- `zstack_ceph_backup_storage`

注意事项：

- 需要真实存储集群、网络和认证信息。
- Ceph pool、primary storage、backup storage 的生命周期和容量影响较大。
- 生产使用前必须确认是否已有业务数据。

## Other Platform Resources

适用场景：平台辅助能力、日志、计费、数据集、容器端点等。

资源：

- `zstack_directory`
- `zstack_dataset`
- `zstack_price_table`
- `zstack_email_media`
- `zstack_log_server`
- `zstack_snmp_agent`
- `zstack_container_management_endpoint`

注意事项：

- `zstack_price_table` 会影响计费模型，需审批。
- `zstack_log_server`、`zstack_snmp_agent` 依赖外部运维系统。
- `zstack_container_management_endpoint` 依赖容器平台连接信息。
- `zstack_dataset` 适合 AI/数据类场景，需确认数据生命周期和权限。

## 后续展开条件

满足以下条件之一时，再为某个 P3 分类补充详细文档和 examples：

- 有明确客户项目需要。
- 有可用于验证的真实环境。
- provider examples/tests 已覆盖关键生命周期。
- 能明确资源依赖、创建顺序、清理方式和回滚策略。

## Agent 生成规则

当 agent 遇到 P3 资源请求时：

- 先确认客户环境和外部系统是否存在。
- 只使用 provider docs/examples/tests 中确认的字段。
- 缺少 UUID、设备地址、凭证或外部系统信息时，生成变量占位。
- 不声称未验证的 P3 example 可直接生产运行。
