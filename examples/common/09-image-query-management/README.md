# 09-image-query-management

Queries an existing image and optionally creates a new image from a URL.

For first-time VM examples, query existing images with `data "zstack_images"`.
Creating images is an administrator workflow because it depends on backup
storage, image URL availability, image format, and download time.
