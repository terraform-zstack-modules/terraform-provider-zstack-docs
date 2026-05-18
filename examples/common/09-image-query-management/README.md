# 09-image-query-management

Queries an existing image and optionally creates a new image from a URL.

For first-time VM examples, query existing images with `data "zstack_images"`.
Creating images is an administrator workflow because it depends on backup
storage, image URL availability, image format, and download time.

## Inputs

Set the source image lookup variables first. To create a managed image, enable
image creation and provide the image URL, backup storage UUID, platform, format,
and guest OS metadata.

## Run

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

## Cleanup

Run `terraform destroy` only for images this example created and no longer need.
