# Resource Stack

Resource stack resources support template-based delivery.

Common resources:

- `zstack_stack_template`
- `zstack_resource_stack`
- `zstack_preconfiguration_template`

## Guidance

- Keep stack templates versioned and reviewed.
- Confirm required parameters before creating a resource stack.
- Preconfiguration templates must follow the system variable requirements of the
  ZStack environment.
- Avoid embedding real passwords or tokens in template content.

See `examples/common/23-resource-stack`.
