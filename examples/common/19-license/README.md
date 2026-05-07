# 19-license

Queries license capacity and optionally uploads a license.

License text is sensitive. Do not commit license content in `terraform.tfvars`.
Use a secure variable source or CI/CD secret store.
Provider 1.1.3 queries authorized nodes without `name_pattern`; use `uuid` or
provider-supported filters if you need to narrow the result.
