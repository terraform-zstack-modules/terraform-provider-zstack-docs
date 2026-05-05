# 镜像

镜像是创建 VM 的基础。P0 中先覆盖“查询已有镜像”，再覆盖“创建/管理镜像”。

## 查询已有镜像

```hcl
data "zstack_images" "ubuntu" {
  name = var.image_name

  filter {
    name   = "status"
    values = ["Ready"]
  }
}
```

建议使用版本化、可识别的镜像名称，例如 `Ubuntu-24.04-2026-04`，避免过于宽泛的 `Ubuntu`。

## 创建镜像

创建镜像是管理员工作流，通常需要：

- 镜像 URL。
- 格式：`qcow2`、`raw`、`vmdk` 等。
- backup storage UUID。
- platform、guest OS、architecture、boot mode。

```hcl
resource "zstack_image" "managed" {
  name                 = var.new_image_name
  url                  = var.new_image_url
  format               = "qcow2"
  platform             = "Linux"
  guest_os_type        = "Linux"
  backup_storage_uuids = [var.backup_storage_uuid]
}
```

## 对应 Example

见 `examples/common/09-image-query-management`。
