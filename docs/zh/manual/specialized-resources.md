# 专项资源

专项资源面向行业、硬件或集成场景。它们通常依赖特定环境、外部系统或硬件设备，不适合作为通用入门示例直接套用。

使用这些资源前，应先确认目标环境、资源依赖、创建顺序、清理方式和回滚策略。没有真实环境验证时，文档只提供资源索引和风险提示。

## 裸金属

适用场景：裸金属资源纳管、PXE 启动、裸金属实例交付。

资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_baremetal_chassis` | resource | 管理裸金属机箱或物理服务器接入对象。 |
| `zstack_baremetal_instance` | resource | 管理裸金属实例生命周期。 |
| `zstack_baremetal_pxe_server` | resource | 管理裸金属 PXE 启动服务。 |

注意事项：

- 需要真实裸金属环境和网络启动配置。
- PXE、机箱、实例之间存在强依赖，不能凭空生成 UUID。
- 建议先从只读查询和单资源导入开始。

## 外部平台与混合云

适用场景：外部虚拟化平台接入、混合云或阿里云代理资源。

资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_vcenter` | resource | 管理接入 ZStack 的 vCenter 资源。 |
| `zstack_aliyun_proxy_vpc` | resource | 管理 ZStack 侧代理的阿里云 VPC 对象。 |
| `zstack_aliyun_proxy_vswitch` | resource | 管理 ZStack 侧代理的阿里云 vSwitch 对象。 |
| `zstack_aliyun_nas_access_group` | resource | 管理阿里云 NAS 访问组相关配置。 |

注意事项：

- 需要外部平台账号、网络连通性和授权。
- Terraform 管理的是 ZStack 侧资源，外部云侧状态可能还需要外部工具验证。
- 不应在通用示例中写真实云账号、AK/SK 或网络地址。

## 安全设备

适用场景：对接行业安全设备、加密机或专用安全能力。

资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_jit_security_machine` | resource | 管理 JIT 安全设备接入对象。 |
| `zstack_san_sec_security_machine` | resource | 管理 SAN_SEC 安全设备接入对象。 |
| `zstack_info_sec_security_machine` | resource | 管理信息安全设备接入对象。 |
| `zstack_fi_sec_security_machine` | resource | 管理 FI_SEC 安全设备接入对象。 |
| `zstack_flk_sec_security_machine` | resource | 管理 FLK_SEC 安全设备接入对象。 |

注意事项：

- 强依赖厂商设备、证书、网络和安全策略。
- 变更前需要安全团队审批。
- 示例应只使用占位变量，不应包含真实设备地址或凭证。

## 存储硬件

适用场景：接入和管理专项存储资源。

资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_iscsi_server` | resource | 管理 iSCSI 存储服务器接入对象。 |
| `zstack_nvme_server` | resource | 管理 NVMe 存储服务器接入对象。 |
| `zstack_ceph_pool` | resource | 管理 Ceph pool。 |
| `zstack_ceph_primary_storage` | resource | 管理 Ceph 主存储，用于承载 VM root/data volume。 |
| `zstack_ceph_backup_storage` | resource | 管理 Ceph 镜像存储/备份存储，用于镜像和备份类数据。 |

注意事项：

- 需要真实存储集群、网络和认证信息。
- Ceph pool、primary storage、backup storage 的生命周期和容量影响较大。
- 生产使用前必须确认是否已有业务数据。

## 其他平台资源

适用场景：平台辅助能力、日志、计费、数据集、容器端点等。

资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_directory` | resource | 管理平台目录类对象。 |
| `zstack_dataset` | resource | 管理数据集对象，常见于数据或 AI 相关场景。 |
| `zstack_price_table` | resource | 管理价格表，会影响计费模型。 |
| `zstack_email_media` | resource | 管理邮件媒介配置，用于通知发送。 |
| `zstack_log_server` | resource | 管理外部日志服务器接入。 |
| `zstack_snmp_agent` | resource | 管理 SNMP agent 接入。 |
| `zstack_container_management_endpoint` | resource | 管理容器平台接入端点。 |

注意事项：

- `zstack_price_table` 会影响计费模型，需审批。
- `zstack_log_server`、`zstack_snmp_agent` 依赖外部运维系统。
- `zstack_container_management_endpoint` 依赖容器平台连接信息。
- `zstack_dataset` 适合 AI/数据类场景，需确认数据生命周期和权限。

## 使用前检查

在为专项资源编写可运行示例或纳入生产管理前，至少确认：

- 有可用于验证的真实环境。
- provider 文档、示例或测试已覆盖关键生命周期。
- 能明确资源依赖、创建顺序、清理方式和回滚策略。
- 缺少 UUID、设备地址、凭证或外部系统信息时，使用变量占位。
- 未经过真实环境验证的示例，不应标注为可直接生产运行。
