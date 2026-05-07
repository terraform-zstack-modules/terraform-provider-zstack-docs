# Anti-Patterns

Avoid:

- Inventing ZStack resource names or attributes.
- Recommending old `l3_network_uuids` for new VM examples.
- Hard-coding real credentials or AccessKeys.
- Committing `terraform.tfvars`, state, plan files, or secrets.
- Using broad `name_pattern` in production examples without reviewing results.
- Claiming an example is runnable when required UUIDs or resource names are missing.
- Mixing public Registry provider source with private/internal source in the same example.
- Using `count` for long-lived batches where stable identity matters.
- Generating fake metric namespaces, route targets, or webhook payload formats without checking the customer environment.
- Printing AccessKey secrets or generated passwords in non-sensitive outputs.
- Updating `zstack_global_config` without first querying and reviewing the current/default value.
- Embedding license text in committed files.
- Creating CDP tasks from fuzzy-matched resource lists.
- Guessing scheduler job types or backup storage compatibility.
- Guessing port mirror endpoint formats or IPsec cryptographic settings.
- Generating P3 specialized resource examples without a real customer environment and required hardware/external system context.
