variable "create_scaling_group" {
  type        = bool
  description = "Whether to create the ess scaling group"
  default     = false
}

variable "create_balancer" {
  type        = bool
  description = "Whether to create the load balancer"
  default     = false
}

variable "create_server_group" {
  type        = bool
  description = "Whether to create the alb server group"
  default     = false
}

variable "create_acl" {
  type        = bool
  description = "Whether to create the alb acl"
  default     = false
}

variable "create_listener" {
  type        = bool
  description = "Whether to create the alb listener"
  default     = false
}

variable "create_server_group_attachment" {
  type        = bool
  description = "Whether to create the ess server group attachment"
  default     = false
}

variable "create_scaling_configuration" {
  type        = bool
  description = "Whether to create the ess scaling configuration"
  default     = false
}


#alicloud_ess_scaling_group
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

variable "desired_capacity" {
  type        = number
  description = "Expected number of ECS instances in the scaling group. Value range: [min_size, max_size]."
  default     = 1
}

variable "scaling_group_name" {
  type        = string
  description = "Name shown for the scaling group, which must contain 2-64 characters (English or Chinese), starting with numbers, English letters or Chinese characters, and can contain numbers, underscores _, hyphens -, and decimal points .. If this parameter is not specified, the default value is ScalingGroupId."
  default     = null
}

variable "default_cooldown" {
  type        = number
  description = "Default cool-down time (in seconds) of the scaling group. Value range: [0, 86400]. The default value is 300s."
  default     = 300
}

variable "vswitch_ids" {
  type        = list(string)
  description = "List of virtual switch IDs in which the ecs instances to be launched."
  default     = []
}

variable "removal_policies" {
  type        = list(string)
  description = "RemovalPolicy is used to select the ECS instances you want to remove from the scaling group when multiple candidates for removal exist."
  default     = []
}

variable "db_instance_ids" {
  type        = list(string)
  description = "If an RDS instance is specified in the scaling group, the scaling group automatically attaches the Intranet IP addresses of its ECS instances to the RDS access whitelist."
  default     = []
}

variable "scaling_group_id" {
  type        = string
  description = "An existing ess scaling group id. It will be ignored when create_scaling_group = true"
  default     = ""
}

variable "server_group_id" {
  type        = string
  description = "An existing alb server id. It will be ignored when create_server_group = true"
  default     = ""
}


variable "multi_az_policy" {
  type        = string
  description = "Multi-AZ scaling group ECS instance expansion and contraction strategy. PRIORITY, BALANCE or COST_OPTIMIZED(Available in 1.54.0+)."
  default     = "PRIORITY"
}

variable "on_demand_base_capacity" {
  type        = number
  description = "The minimum amount of the Auto Scaling group's capacity that must be fulfilled by On-Demand Instances. This base portion is provisioned first as your group scales."
  default     = null
}

variable "on_demand_percentage_above_base_capacity" {
  type        = number
  description = "Controls the percentages of On-Demand Instances and Spot Instances for your additional capacity beyond OnDemandBaseCapacity."
  default     = null
}

variable "spot_instance_pools" {
  type        = number
  description = "The number of Spot pools to use to allocate your Spot capacity. The Spot pools is composed of instance types of lowest price."
  default     = null
}

variable "spot_instance_remedy" {
  type        = bool
  description = "Whether to replace spot instances with newly created spot/onDemand instance when receive a spot recycling message."
  default     = null
}

variable "group_deletion_protection" {
  type        = bool
  description = "Specifies whether the scaling group deletion protection is enabled. true or false, Default value: false."
  default     = false
}
variable "launch_template_id" {
  type        = string
  description = "Instance launch template ID, scaling group obtains launch configuration from instance launch template, see Launch Template. Creating scaling group from launch template enable group automatically."
  default     = null
}

variable "pay_type" {
  type        = string
  description = "The billing method of the ALB instance. Valid value: PayAsYouGo."
  default     = "PayAsYouGo"
}

variable "default_action_type" {
  type        = string
  description = "The Action Type."
  default     = "ForwardGroup"
}

variable "acl_type" {
  type        = string
  description = "The type of the ACL. Valid values: White Or Black."
  default     = "White"
}

variable "listener_protocol" {
  type        = string
  description = "Snooping Protocols. Valid Values: HTTP, HTTPS Or QUIC."
  default     = "HTTP"
}

variable "launch_template_version" {
  type        = string
  description = "The version number of the launch template. Valid values are the version number, Latest, or Default, Default value: Default."
  default     = null
}

#alicloud_alb_load_balancer
variable "vpc_id" {
  type        = string
  description = "The vpc that the ALB belong to."
  default     = null
}

variable "zone_mappings" {
  type = list(object({
    vswitch_id = string
    zone_id    = string
  }))
  description = "zone mappings which bind to alb group."
}

variable "address_type" {
  default     = "Internet"
  type        = string
  description = "The address type of ALB."
}

variable "address_allocated_mode" {
  default     = "Fixed"
  type        = string
  description = "The address allocated mode of ALB."
}

variable "load_balancer_name" {
  default     = null
  type        = string
  description = "The name of ALB."
}

variable "load_balancer_edition" {
  default     = "Basic"
  type        = string
  description = "The edition of ALB."
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "modification_protection_config_status" {
  description = "Specifies whether to enable the configuration read-only mode for the ALB instance."
  type        = string
  default     = "NonProtection"
}
variable "modification_protection_config_reason" {
  description = "The reason for modification protection."
  type        = string
  default     = null
}

variable "access_log_config" {
  type = list(object({
    log_project = string
    log_store   = string
  }))
  description = "The Access Logging Configuration Structure."
  default     = []
}

#alicloud_alb_server_group
variable "server_group_name" {
  default     = null
  type        = string
  description = "The name of server group"
}

variable "protocol" {
  type        = string
  description = "The server protocol. Valid values: HTTPS, HTTP."
  default     = "HTTP"
}

variable "resource_group_id" {
  description = "The ID of the resource group."
  type        = string
  default     = null
}

variable "health_check_config" {
  default     = {}
  type        = map(string)
  description = "The configuration of health checks."
}

variable "sticky_session_config" {
  default     = {}
  type        = map(string)
  description = "The configuration of the sticky session."
}

#alicloud_alb_acl
variable "acl_name" {
  default     = null
  type        = string
  description = "The name of acl"
}

variable "listener_port" {
  default     = null
  type        = number
  description = "The port of ALB listener."
}

variable "listener_description" {
  default     = null
  type        = string
  description = "The description of ALB listener."
}

#alicloud_ess_scaling_configuration
variable "image_id" {
  type        = string
  description = "ID of an image file, indicating the image resource selected when an instance is enabled."
  default     = null
}

variable "instance_type" {
  type        = string
  description = "Resource types of an ECS instance."
  default     = null
}

variable "security_group_id" {
  type        = string
  description = "ID of the security group used to create new instance."
  default     = null
}

variable "port" {
  type        = number
  description = "The port will be used for Alb Server Group backend server."
  default     = null
}

variable "weight" {
  type        = number
  description = "The weight of an ECS instance attached to the Alb Server Group."
  default     = null
}

variable "force_attach" {
  type        = bool
  description = "If instances of scaling group are attached/removed from slb backend server when attach/detach alb server group from scaling group. Default to false."
  default     = false
}

variable "force_delete" {
  type        = bool
  description = "The last scaling configuration will be deleted forcibly with deleting its scaling group. Default to false."
  default     = false
}

variable "enable" {
  type        = bool
  description = "Whether enable the specified scaling group(make it active) to which the current scaling configuration belongs."
  default     = false
}


variable "active" {
  type        = bool
  description = "Whether active current scaling configuration in the specified scaling group."
  default     = false
}
