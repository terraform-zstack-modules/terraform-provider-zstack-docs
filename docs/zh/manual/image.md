# 镜像

镜像是创建 VM 的基础。建议先查询已有镜像，再根据需要创建或管理镜像。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_images` | data source | 查询已有镜像，给 VM 创建或镜像管理流程选择 `image_uuid`。 |
| `zstack_image` | resource | 创建并管理镜像，需要镜像 URL、格式、平台信息和镜像存储 UUID。 |

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

## 对应示例

见 [examples/common/09-image-query-management](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/09-image-query-management)。
