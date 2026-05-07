# FAQ

## Provider source 应该用哪个？

公网 Terraform Registry 使用 `ZStack-Robot/zstack`。ZStack 应用市场或内网 Registry 使用平台配置的内部 source，例如 `zstack.io/terraform-provider-zstack/zstack`。内部 source 以客户 ZStack 平台或私有 Registry 实际显示的字符串为准，不要在不同来源之间自行拼接。

## 为什么推荐 AccessKey？

AccessKey 更适合自动化和权限管理。账号密码方式仅作为兼容选项。

## 什么时候用 UUID，什么时候用 name？

自动化、CI/CD、agent 生成配置时优先 UUID。人工编写且名称唯一时可以用 name。`name_pattern` 只适合探索和调试。

## examples 可以直接用于生产吗？

examples 是可运行起点，不是完整生产模块。生产使用前需要补充 backend、变量校验、权限、命名规范、标签和审批流程。

## 创建 VM 应该用 `l3_network_uuids` 吗？

新配置不推荐。使用 `network_interfaces`，它能表达默认网卡、静态 IP 和多网卡。

## 如何管理多个环境？

使用不同的变量文件、workspace 或独立目录，并配合 remote backend。不要在同一个 state 中混放无关环境。

## 如何导入已有资源？

先写 resource block，再运行 `terraform import` 或使用 import block。导入后必须执行 `terraform plan` 并修正差异。

## 是否支持离线环境？

支持，但需要配置内部 provider source 或 Terraform provider mirror，并确认 ZStack provider 版本在内网可用。

## Provider 版本应该怎么升级？

本文档和示例基于 provider `1.1.3`。升级时统一修改 `required_providers.zstack.version`，执行 `terraform init -upgrade`，再对要发布或演示的场景逐一执行 `terraform plan`。未验证的新版本按 migration 处理，不要直接批量替换后 apply。

## 升级到 1.1.3 有哪些字段变化？

`zstack_access_key` 需要 `user_uuid`，`zstack_sns_email_endpoint` 需要
`platform_uuid`，`zstack_license_authorized_nodes` 不再支持
`name_pattern`。资源编排功能及编排模板已取消，不再维护对应 example。

## Load Balancer example 为什么没有完整后端绑定？

后端成员绑定方式和客户环境、provider 版本、网络模型有关。第一版 example 先创建 VIP、LB、listener 和 server group，并输出 UUID，后续按环境补后端绑定。

## 脚本初始化适合做什么？

适合 day-1 初始化，例如安装软件、配置 agent、写入基础配置。不适合写入长期密钥、私钥或不可审计的大型脚本。

## Tag 应该怎么设计？

建议先统一少量标准 tag：`environment`、`owner`、`application`、`cost-center`。不要让每个团队自由发明一套命名。

## IAM examples 可以直接在生产跑吗？

不建议直接跑。IAM 会创建账号、虚拟身份和 AccessKey，必须先确认权限边界、密码策略和 secret 保存方式。

## Global Config 可以直接交给 Terraform 管理吗？

可以，但不建议直接在生产环境首次 apply。应先用 data source 查询当前值、默认值和说明，确认影响范围后再纳管。

## License 文本应该放在哪里？

放在 secret store、CI/CD secret 或本地未提交的敏感变量文件中。不要提交到 Git，也不要输出到普通日志。

## CDP 和 Backup examples 为什么有很多 `replace-me`？

备份/CDP 强依赖真实资源 UUID、backup storage 类型和业务保留策略。文档不能替客户编造这些值，必须由管理员从环境中确认。

## Scheduler 的 job type 应该填什么？

取决于 ZStack 环境支持的任务类型。使用前应查询或确认平台支持的 job type，不要让 agent 自行猜测。

## Network Observability example 能直接套用吗？

不能直接套用。采集器地址、端口、flow meter 类型、mirror endpoint 格式都依赖客户网络设计，需要先由管理员确认。

## IPsec 的算法字段可以省略吗？

如果 ZStack 和对端有默认协商策略，可以先省略；生产环境建议明确记录双方使用的算法、PFS 和 transform protocol。
