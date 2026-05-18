# 存储

存储章节优先覆盖 VM 数据盘、快照和基础存储查询。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_disk_offerings` | data source | 查询云盘规格，用于创建数据盘或确认磁盘容量规格。 |
| `zstack_primary_storages` | data source | 查询主存储，主存储承载 VM root volume 和 data volume。 |
| `zstack_backup_storages` | data source | 查询镜像存储/备份存储，常用于镜像、镜像导入和部分备份/CDP 流程。 |
| `zstack_volume` | resource | 创建并管理数据盘，可单独挂载到 VM。 |
| `zstack_volume_snapshot` | resource | 创建并管理数据盘快照，用于备份或恢复点。 |

## 数据盘建模方式

有两种常见方式：

1. 在 `zstack_instance` 中使用 `data_disks`，适合数据盘跟随 VM 生命周期。
2. 独立使用 `zstack_volume` 并设置 `vm_instance_uuid`，适合数据盘有独立生命周期。

本手册优先展示第二种，因为它更直观，也便于单独导入、扩容和备份。

## 示例

```hcl
resource "zstack_volume" "data" {
  name               = var.data_volume_name
  disk_offering_uuid = data.zstack_disk_offerings.data.disk_offers[0].uuid
  vm_instance_uuid   = zstack_instance.vm.uuid
}
```

## 对应示例

见 [examples/common/08-volume](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume)。
