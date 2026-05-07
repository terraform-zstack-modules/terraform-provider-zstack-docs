output "account_uuid" {
  description = "Automation account UUID."
  value       = zstack_account.automation.uuid
}

output "project_uuid" {
  description = "IAM2 project UUID."
  value       = zstack_iam2_project.automation.uuid
}

output "virtual_id_uuid" {
  description = "IAM2 virtual ID UUID."
  value       = zstack_iam2_virtual_id.automation.uuid
}

output "access_key_id" {
  description = "Generated AccessKey ID. Store it in a secret manager."
  value       = zstack_access_key.automation.access_key_id
  sensitive   = true
}

output "access_key_secret" {
  description = "Generated AccessKey Secret. Store it in a secret manager immediately."
  value       = zstack_access_key.automation.access_key_secret
  sensitive   = true
}
