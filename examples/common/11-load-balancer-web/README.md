# 11-load-balancer-web

Creates a VIP, load balancer, listener, and server group for a web service.

This example does not register backend VM NICs because backend membership can
vary by environment and provider version. Use the output UUIDs as the base for
backend attachment workflows supported in your environment.
