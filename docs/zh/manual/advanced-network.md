# Advanced Network

P2 高级网络场景覆盖站点互联和策略路由。此类配置强依赖网络规划，不能由 agent 猜测 peer 地址、密钥、路由表或策略值。

## 常用资源

- `zstack_ipsec_connection`
- `zstack_policy_route_rule_set`
- `zstack_policy_route_rule`

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

对应 example：`examples/common/22-advanced-network`。
