# 存储

P0 存储优先覆盖 VM 数据盘、快照和基础存储查询。

## 常用资源

- `zstack_disk_offerings`
- `zstack_primary_storages`
- `zstack_backup_storages`
- `zstack_volume`
- `zstack_volume_snapshot`

## 数据盘建模方式

有两种常见方式：

1. 在 `zstack_instance` 中使用 `data_disks`，适合数据盘跟随 VM 生命周期。
2. 独立使用 `zstack_volume` 并设置 `vm_instance_uuid`，适合数据盘有独立生命周期。

客户手册第一版优先展示第二种，因为它更直观，也便于单独导入、扩容和备份。

## 示例

```hcl
resource "zstack_volume" "data" {
  name               = var.data_volume_name
  disk_offering_uuid = data.zstack_disk_offerings.data.disk_offers[0].uuid
  vm_instance_uuid   = zstack_instance.vm.uuid
}
```

## 对应 Example

见 `examples/common/08-volume`。
