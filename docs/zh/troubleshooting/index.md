# Troubleshooting

## Provider 下载失败

- 检查 `required_providers.zstack.source`。
- 公网环境使用 `ZStack-Robot/zstack`。
- 内网或应用市场环境使用平台配置的内部 source；以平台或私有 Registry 实际显示的 source 字符串为准。
- 确认 Terraform CLI 能访问对应 registry。

## 认证失败

- 检查 `ZSTACK_HOST`、`ZSTACK_PORT`、AccessKey ID/Secret。
- 确认运行 Terraform 的机器可以访问 ZStack 管理节点。
- 确认 AccessKey 权限覆盖目标资源。
- 不要同时混用 AccessKey 和账号密码。

## Data Source 查不到资源

- 先使用 ZStack 控制台确认资源名称或 UUID。
- 优先使用 `uuid` 做精确查询。
- 如果使用 `name_pattern`，输出完整结果检查匹配范围。
- 检查资源状态，例如镜像是否 `Ready`、`Enabled`。

## VM 创建失败

- 检查 image、L3 network、instance offering 是否存在。
- 检查 `network_interfaces` 是否使用正确 L3 UUID。
- 静态 IP 失败时，确认 IP 在可用范围内且未被占用。
- 使用 `cpu_num` + `memory_size` 时，不要再同时设置 `instance_offering_uuid`。

## 安全组不生效

- 确认安全组已通过 `zstack_networking_secgroup_attachment` 绑定到 VM NIC。
- 检查规则方向：`Ingress` 或 `Egress`。
- 检查 `ip_ranges`、`destination_port_ranges`、`priority` 和 `state`。

## Import 后 plan 想重建资源

- import 不会自动生成完整 HCL。
- 补齐 resource block 后再次 plan。
- 在 `terraform plan` 达到 no-op 或只包含明确接受的变更前，不要执行 `terraform apply`。
- 如果是不可变字段差异，先决定是否接受 replacement。
- 不确定时不要 apply。

## Load Balancer 不通

- 确认 VIP 所在 L3 网络可达。
- 确认 listener 的 `load_balancer_port` 和 `instance_port` 正确。
- 确认后端 VM 防火墙和安全组允许后端端口。
- 输出并核对 LB、listener、server group UUID。

## 脚本执行失败

- 检查 `script_type`、`encoding_type` 和 `script_timeout`。
- 确认目标 VM 状态和 guest agent/执行通道满足脚本执行要求。
- 不要把复杂长脚本直接塞进 HCL，生产建议从模板或文件生成。

## IAM / AccessKey 问题

- AccessKey secret 创建后只在创建阶段可见，应及时保存。
- Provider `1.1.3` 创建 `zstack_access_key` 时需要 `user_uuid`。
- 检查 account、user、virtual ID 的权限边界。
- 不要把敏感 output 打到普通 CI 日志。

## 告警或通知不触发

- 确认 metric namespace 和 metric name 在当前环境存在。
- 创建 SNS email endpoint 时确认 `platform_uuid` 来自真实环境。
- 检查 threshold、period、comparison operator。
- 检查通知端点是否启用以及 Webhook URL 是否可达。

## Scheduler 未按预期执行

- 确认 `scheduler_type`、`cron`、`scheduler_interval` 和 `start_time`。
- 检查 `job_type` 是否被当前环境支持。
- 检查 target resource UUID 是否正确且资源状态允许执行任务。

## Global Config 修改风险

- 先查询当前值、默认值和描述。
- 如果不确定影响范围，保持 `manage_global_config = false`。
- 修改后如出现平台行为变化，使用变更记录恢复原值。

## License 上传失败

- 检查 management node UUID。
- `zstack_license_authorized_nodes` 在 provider `1.1.3` 中不支持
  `name_pattern`，不要沿用旧版本参数。
- 确认 license 文本完整且没有换行/转义损坏。
- 不要在日志中打印 license 内容。

## Backup/CDP 失败

- 确认 backup storage UUID 类型正确。
- Volume backup 要使用支持的 ImageStoreBackupStorage。
- 检查 CDP resource UUID、task type、容量和带宽限制。
- ZBox backup 依赖具体 ZBox 环境，先使用 dry run。

## Flow / Port Mirror 不采集数据

- 检查 collector server 和 port 是否可达。
- 确认 flow meter type/version 与采集端兼容。
- 检查 mirror network UUID、source endpoint、destination endpoint 格式。

## IPsec 或策略路由不生效

- 确认 VIP、peer address、auth key 与对端配置一致。
- 检查加密算法、认证算法和 PFS 设置。
- 检查 policy route rule 的 route table UUID、rule number 和匹配条件。
