# 导入已有资源

当 ZStack 中已有资源需要转为 Terraform 管理时，使用 import。

## 推荐流程

1. Write the Terraform resource block with the intended final configuration.
2. Import the remote object into state.
3. Run `terraform plan`.
4. Adjust configuration until the plan shows no unintended replacement.

!!! warning
    import 后必须反复执行 `terraform plan` 并补齐 resource block，直到
    plan 达到 no-op 或只包含明确接受的变更。在 plan 显示 replacement
    或未知变更时不要执行 `terraform apply`，否则可能重建已有资源。

## CLI Import

```bash
terraform import zstack_instance.existing <vm-uuid>
terraform plan
```

## Import Block

Terraform 1.5+ 可使用 import block：

```hcl
import {
  to = zstack_instance.existing
  id = var.existing_vm_uuid
}
```

## 注意事项

- import 只写入 state，不会自动生成完整 HCL。
- import 后第一次 `plan` 可能出现差异，需要补齐 resource block。
- 如果 plan 显示 replacement，先分析不可变字段，不要直接 apply。
- 不是所有 resource 都适合导入；如果不支持 import，可先作为 data source 查询。

## 对应 Example

见 `examples/common/10-import-existing-vm`。
