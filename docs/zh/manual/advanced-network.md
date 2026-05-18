# 高级网络

高级网络场景覆盖站点互联和策略路由。此类配置强依赖网络规划，不能凭空填写 peer 地址、密钥、路由表或策略值。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_ipsec_connection` | resource | 创建 IPsec 站点互联连接，配置 VIP、对端地址和认证密钥。 |
| `zstack_policy_route_rule_set` | resource | 创建策略路由规则集，用于组织一组策略路由规则。 |
| `zstack_policy_route_rule` | resource | 创建策略路由规则，按源/目的地址、协议等条件匹配并关联路由表。 |

## IPsec

```hcl
resource "zstack_ipsec_connection" "site_to_site" {
  name         = var.ipsec_name
  vip_uuid     = var.vip_uuid
  peer_address = var.peer_address
  auth_key     = var.auth_key
}
```

`auth_key` 是敏感信息，应使用 sensitive variable。

## Policy Route

策略路由由 rule set 和 rule 组成，rule 需要关联 route table：

```hcl
resource "zstack_policy_route_rule" "main" {
  rule_set_uuid = zstack_policy_route_rule_set.main.uuid
  table_uuid    = var.route_table_uuid
  rule_number   = var.rule_number
  dest_ip       = var.dest_ip
}
```

如果设置 `protocol`，使用 provider schema 接受的大写值：`TCP`、`UDP` 或
`ICMP`。

对应示例：[examples/common/22-advanced-network](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/22-advanced-network)。
