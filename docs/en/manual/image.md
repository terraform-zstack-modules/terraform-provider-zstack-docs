# Image

Images are the foundation for VM creation. Query existing images first, then
create or manage images only when needed.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_images` | data source | Query existing images and select `image_uuid` for VM creation or image workflows. |
| `zstack_image` | resource | Create and manage an image with image URL, format, platform metadata, and backup storage UUID. |

## Query Existing Images

```hcl
data "zstack_images" "ubuntu" {
  name = var.image_name

  filter {
    name   = "status"
    values = ["Ready"]
  }
}
```

Use versioned, recognizable image names such as `Ubuntu-24.04-2026-04`. Avoid
overly broad names such as `Ubuntu`.

## Create Image

Creating images is an administrator workflow. It usually requires:

- Image URL.
- Format: `qcow2`, `raw`, `vmdk`, and similar.
- Backup storage UUID.
- Platform, guest OS, architecture, and boot mode.

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

## Related Example

See [examples/common/09-image-query-management](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/09-image-query-management).
