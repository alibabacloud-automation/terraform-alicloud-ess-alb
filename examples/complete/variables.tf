variable "min_size" {
  type        = number
  description = "Minimum number of ECS instances in the scaling group. Value range: [0, 1000]."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of ECS instances in the scaling group. Value range: [0, 1000]."
  default     = 4
}

variable "scaling_group_name" {
  type        = string
  description = "Name shown for the scaling group, which must contain 2-64 characters (English or Chinese), starting with numbers, English letters or Chinese characters, and can contain numbers, underscores _, hyphens -, and decimal points .. If this parameter is not specified, the default value is ScalingGroupId."
  default     = "scaling_group_name"
}

variable "removal_policies" {
  type        = list(string)
  description = "RemovalPolicy is used to select the ECS instances you want to remove from the scaling group when multiple candidates for removal exist."
  default     = ["OldestInstance", "NewestInstance"]
}

variable "default_cooldown" {
  type        = number
  description = "Default cool-down time (in seconds) of the scaling group. Value range: [0, 86400]. The default value is 300s."
  default     = 20
}

variable "spot_instance_remedy" {
  type        = bool
  description = "Whether to replace spot instances with newly created spot/onDemand instance when receive a spot recycling message."
  default     = false
}

variable "server_group_name" {
  type        = string
  description = "The name of the resource."
  default     = "acl_server_group_name"
}

variable "load_balancer_name" {
  type        = string
  description = "The name of the resource."
  default     = "tf_alb_name"
}

variable "log_store_name" {
  default     = "tflogstorename"
  type        = string
  description = "The name of log store."
}

variable "log_project_name" {
  default     = "tflogprojectname"
  type        = string
  description = "The name of log project."
}

variable "vpc_name" {
  default     = "tf_vpc_name"
  type        = string
  description = "The name of VPC."
}

variable "vpc_cidr_block" {
  default     = "11.0.0.0/16"
  type        = string
  description = "The CIDR block of VPC."
}

variable "vswitch_name_1" {
  default     = "tf_vswitch_name_1"
  type        = string
  description = "The name of one v_switch."
}

variable "vswitch_name_2" {
  default     = "tf_vswitch_name_2"
  type        = string
  description = "The name of the other v_switch."
}

variable "force_delete" {
  type        = bool
  description = "The last scaling configuration will be deleted forcibly with deleting its scaling group. Default to false."
  default     = true
}

variable "active" {
  type        = bool
  description = "Whether active current scaling configuration in the specified scaling group. Default to false."
  default     = true
}

variable "acl_name" {
  type        = string
  description = "The name of the ACL. The name must be 2 to 128 characters in length, and can contain letters, digits, hyphens (-) and underscores (_). It must start with a letter."
  default     = "acl_name"
}

variable "enable" {
  type        = bool
  description = "Whether enable the specified scaling group(make it active) to which the current scaling configuration belongs."
  default     = true
}

variable "force_attach" {
  type        = bool
  description = "If instances of scaling group are attached/removed from slb backend server when attach/detach alb server group from scaling group. Default to false."
  default     = true
}

