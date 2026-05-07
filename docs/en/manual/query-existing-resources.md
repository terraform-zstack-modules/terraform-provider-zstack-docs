# Query Existing Resources

Use data sources before creating resources. This avoids hard-coded UUIDs and
keeps examples portable across ZStack environments.

Common data sources:

- `zstack_images`
- `zstack_l3networks`
- `zstack_instance_offerings`
- `zstack_disk_offerings`
- `zstack_zone`
- `zstack_clusters`
- `zstack_hosts`
- `zstack_l2networks`
- `zstack_virtual_routers`
- `zstack_instances`

## Lookup Strategy

- Use `uuid` for automation when known.
- Use exact `name` for human-authored examples when the name is unique.
- Use `name_pattern` only for discovery and always review the matched output.

## Example

See `examples/common/02-query-existing-resources`.

For first-time environment validation, source only the root `.env`
authentication variables and run the example. It uses broad discovery patterns
by default and outputs candidate images, L3 networks, offerings, zones,
clusters, and hosts for later examples.
