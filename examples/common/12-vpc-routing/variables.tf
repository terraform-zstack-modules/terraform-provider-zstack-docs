variable "zstack_host" {
  description = "ZStack management endpoint host or IP address."
  type        = string
}

variable "zstack_port" {
  description = "ZStack management endpoint port."
  type        = number
  default     = 8080
}

variable "zstack_access_key_id" {
  description = "AccessKey ID used to authenticate to ZStack."
  type        = string
}

variable "zstack_access_key_secret" {
  description = "AccessKey secret used to authenticate to ZStack."
  type        = string
  sensitive   = true
}

variable "vpc_name" {
  description = "Name of the vpc to create or query."
  type        = string
  default     = "tf-vpc-routing"
}

variable "l2_network_name_pattern" {
  description = "L2 network name pattern used by this example."
  type        = string
  default     = "%"
}

variable "virtual_router_name_pattern" {
  description = "Virtual router name pattern used by this example."
  type        = string
  default     = "%"
}

variable "subnet_name" {
  description = "Name of the subnet to create or query."
  type        = string
  default     = "tf-vpc-subnet"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet."
  type        = string
}

variable "subnet_gateway" {
  description = "Gateway address for the subnet."
  type        = string
}

variable "dns" {
  description = "Input value for dns."
  type        = string
  default     = "223.5.5.5"
}

variable "route_table_name" {
  description = "Name of the route table to create or query."
  type        = string
  default     = "tf-vpc-route-table"
}

variable "route_destination" {
  description = "Input value for route destination."
  type        = string
  default     = "0.0.0.0/0"
}

variable "route_target" {
  type        = string
  description = "Route target value expected by ZStack."
}

variable "route_type" {
  description = "Type value for the route."
  type        = string
  default     = "UserStatic"
}

variable "route_distance" {
  description = "Input value for route distance."
  type        = number
  default     = 100
}
