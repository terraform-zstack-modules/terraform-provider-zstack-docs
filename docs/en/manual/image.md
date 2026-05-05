# Image

Images are required for VM creation. Query existing images first, then create or
upload managed images only when the environment and backup storage are known.

## Query Image

Use `zstack_images` with exact name or UUID. Confirm image status before using it
for VM creation.

## Managed Image

`zstack_image` can be used to create a managed image when the image URL, format,
platform, architecture, boot mode, and backup storage are confirmed.

See `examples/common/09-image-query-management`.

## Best Practices

- Prefer querying existing images in customer examples.
- Do not invent image URLs or backup storage UUIDs.
- Make image creation optional when the scenario can use an existing image.
