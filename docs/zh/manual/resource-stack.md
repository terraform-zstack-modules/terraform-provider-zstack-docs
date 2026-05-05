# Resource Stack

P2 Resource Stack 场景用于模板化交付。模板内容应像代码一样评审、版本化和测试。

## 常用资源

- `zstack_stack_template`
- `zstack_resource_stack`
- `zstack_preconfiguration_template`

## Stack Template

`template_content` 必须包含 `ZStackTemplateFormatVersion`：

```hcl
resource "zstack_stack_template" "template" {
  name = var.stack_template_name
  template_content = jsonencode({
    ZStackTemplateFormatVersion = "2018-06-18"
    Resources                   = {}
  })
}
```

## Resource Stack

Resource stack 可以引用 template UUID，也可以直接传 template content。建议客户先使用 template UUID，便于模板复用和审计。

## Preconfiguration Template

自定义 preconfiguration template 必须包含 ZStack 系统变量标记：

- `REPO_URL`
- `USERNAME`
- `PASSWORD`
- `NETWORK_CFGS`
- `FORCE_INSTALL`
- `PRE_SCRIPTS`
- `POST_SCRIPTS`

对应 example：`examples/common/23-resource-stack`。
