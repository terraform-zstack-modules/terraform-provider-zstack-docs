variable "zstack_host" {
  type = string
}

variable "zstack_port" {
  type    = number
  default = 8080
}

variable "zstack_access_key_id" {
  type = string
}

variable "zstack_access_key_secret" {
  type      = string
  sensitive = true
}

variable "existing_image_name" {
  type        = string
  description = "Existing image name to query."
}

variable "create_image" {
  type        = bool
  description = "Whether to create a new image from URL."
  default     = false
}

variable "new_image_name" {
  type        = string
  description = "Name for the image created when create_image is true."
  default     = "tf-managed-image"
}

variable "new_image_url" {
  type        = string
  description = "Image URL used when create_image is true."
  default     = null
}

variable "backup_storage_uuid" {
  type        = string
  description = "Backup storage UUID used when create_image is true."
  default     = null
}

variable "new_image_format" {
  type        = string
  description = "Image format used when create_image is true."
  default     = "qcow2"
}

variable "new_image_platform" {
  type        = string
  description = "Image platform used when create_image is true."
  default     = "Linux"
}

variable "new_image_guest_os_type" {
  type        = string
  description = "Guest OS type used when create_image is true."
  default     = "Linux"
}

variable "new_image_architecture" {
  type        = string
  description = "Image architecture used when create_image is true."
  default     = "x86_64"
}

variable "new_image_boot_mode" {
  type        = string
  description = "Image boot mode used when create_image is true."
  default     = "legacy"
}
