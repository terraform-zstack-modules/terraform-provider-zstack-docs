# P3 执行跟踪

P3 资源是专项/行业/硬件/集成类资源。第一阶段只做索引，不深写可运行场景。

状态说明：

- `Indexed`: 已纳入索引。
- `Pending Scenario`: 等待具体客户场景后再深写。
- `Blocked`: 缺少环境或 schema 信息。

| # | 分类 | 状态 | 文档路径 | Examples 路径 | 备注 |
|---|---|---|---|---|---|
| 1 | Baremetal | Indexed | `docs/zh/manual/specialized-resources.md` | N/A | 需要裸金属环境 |
| 2 | External / Hybrid | Indexed | `docs/zh/manual/specialized-resources.md` | N/A | vCenter、阿里云代理资源，环境依赖强 |
| 3 | Security Machines | Indexed | `docs/zh/manual/specialized-resources.md` | N/A | 加密机/安全设备专项场景 |
| 4 | Storage Hardware | Indexed | `docs/zh/manual/specialized-resources.md` | N/A | iSCSI、NVMe、Ceph，需真实存储环境 |
| 5 | Other Platform Resources | Indexed | `docs/zh/manual/specialized-resources.md` | N/A | 目录、数据集、计费、日志、SNMP、容器端点等 |
