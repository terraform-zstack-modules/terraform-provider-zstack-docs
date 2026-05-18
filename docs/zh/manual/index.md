# 客户使用手册

本手册说明 ZStack provider `1.1.3` 面向客户的使用流程，不是 provider 资源参考的复制版，重点在于如何在真实交付场景中安全使用各类资源。

推荐阅读顺序：

1. 安装 Terraform，确认 runner 可以访问 ZStack 管理节点。
2. 初始化 provider，按环境选择公开 Registry、离线 mirror 或 provider 开发配置。
3. 理解 Terraform 运行流程、概念映射和 provider 工作原理。
4. 配置认证，并通过 data source 查询已有资源。
5. 创建 VM 并配置网络、安全组、磁盘和镜像。
6. 加入生产场景能力，例如 EIP、Load Balancer、VPC、初始化脚本、IAM 与监控通知。
7. 在将已有资源纳入 Terraform 管理前，先阅读导入与迁移指引。
8. 生产 apply 前阅读 HCL 编写规范、调试诊断和生产化指南。
