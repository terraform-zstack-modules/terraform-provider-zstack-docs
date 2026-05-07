# 07-vpc

Creates a basic VPC L3 network with an initial subnet CIDR.

This example looks up the existing L2 network and virtual router with data
sources. Narrow `l2_network_name_pattern` and `virtual_router_name_pattern`
before applying if the broad defaults match more than one candidate.
