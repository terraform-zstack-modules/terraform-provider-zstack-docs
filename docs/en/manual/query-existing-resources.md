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

## Lookup Strategy

- Use `uuid` for automation when known.
- Use exact `name` for human-authored examples when the name is unique.
- Use `name_pattern` only for discovery and always review the matched output.

## Example

See `examples/common/02-query-existing-resources`.

The example queries image, L3 network, instance offering, disk offering, zone,
cluster, and host inputs that are later used by VM, storage, and networking
examples.
