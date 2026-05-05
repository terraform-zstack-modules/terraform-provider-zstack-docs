# 04-create-10-vms

Creates multiple VMs with stable `for_each` keys.

Prefer this pattern over `count` when customers will add or remove individual
VMs later. Stable keys reduce accidental resource replacement.
