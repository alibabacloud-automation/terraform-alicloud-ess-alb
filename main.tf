locals {
  scaling_group_id = var.scaling_group_id != "" ? var.scaling_group_id : concat(alicloud_ess_scaling_group.scaling_group.*.id, [""])[0]
  server_group_id  = var.server_group_id != "" ? var.server_group_id : concat(alicloud_alb_server_group.alb_server_group.*.id, [""])[0]
}

resource "alicloud_ess_scaling_group" "scaling_group" {
  count                                    = var.create_scaling_group ? 1 : 0
  min_size                                 = var.min_size
  max_size                                 = var.max_size
  desired_capacity                         = var.desired_capacity
  scaling_group_name                       = var.scaling_group_name
  default_cooldown                         = var.default_cooldown
  vswitch_ids                              = var.vswitch_ids
  removal_policies                         = var.removal_policies
  db_instance_ids                          = var.db_instance_ids
  multi_az_policy                          = var.multi_az_policy
  on_demand_base_capacity                  = var.on_demand_base_capacity
  on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
  spot_instance_pools                      = var.spot_instance_pools
  spot_instance_remedy                     = var.spot_instance_remedy
  group_deletion_protection                = var.group_deletion_protection
  launch_template_id                       = var.launch_template_id
  launch_template_version                  = var.launch_template_version
  depends_on                               = [alicloud_alb_load_balancer.balancer]
}

resource "alicloud_alb_load_balancer" "balancer" {
  count                  = var.create_balancer ? 1 : 0
  vpc_id                 = var.vpc_id
  address_type           = var.address_type
  address_allocated_mode = var.address_allocated_mode
  load_balancer_name     = var.load_balancer_name
  load_balancer_edition  = var.load_balancer_edition
  tags                   = var.tags
  load_balancer_billing_config {
    pay_type = var.pay_type
  }
  dynamic "zone_mappings" {
    for_each = var.zone_mappings
    content {
      vswitch_id = zone_mappings.value["vswitch_id"]
      zone_id    = zone_mappings.value["zone_id"]
    }
  }
  modification_protection_config {
    status = var.modification_protection_config_status
    reason = var.modification_protection_config_reason
  }

  dynamic "access_log_config" {
    for_each = var.access_log_config
    content {
      log_project = access_log_config.value["log_project"]
      log_store   = access_log_config.value["log_store"]
    }
  }
}

resource "alicloud_alb_server_group" "alb_server_group" {
  count             = var.create_server_group ? 1 : 0
  protocol          = var.protocol
  vpc_id            = var.vpc_id
  server_group_name = var.server_group_name
  resource_group_id = var.resource_group_id

  health_check_config {
    health_check_connect_port = lookup(var.health_check_config, "health_check_connect_port", 80)
    health_check_enabled      = lookup(var.health_check_config, "health_check_enabled", "false")
    health_check_host         = lookup(var.health_check_config, "health_check_host", "")
    health_check_http_version = lookup(var.health_check_config, "health_check_http_version", "HTTP1.1")
    health_check_interval     = lookup(var.health_check_config, "health_check_interval", "2")
    health_check_method       = lookup(var.health_check_config, "health_check_method", "HEAD")
    health_check_path         = lookup(var.health_check_config, "health_check_path", "")
    health_check_protocol     = lookup(var.health_check_config, "health_check_protocol", "")
    health_check_timeout      = lookup(var.health_check_config, "health_check_timeout", "5")
    healthy_threshold         = lookup(var.health_check_config, "healthy_threshold", "3")
    unhealthy_threshold       = lookup(var.health_check_config, "unhealthy_threshold", "3")
  }

  sticky_session_config {
    sticky_session_enabled = lookup(var.sticky_session_config, "sticky_session_enabled", "false")
    cookie                 = lookup(var.sticky_session_config, "cookie", "")
    sticky_session_type    = lookup(var.sticky_session_config, "sticky_session_type", "Server")
  }
  tags = var.tags
}

resource "alicloud_alb_acl" "alb_acl" {
  count             = var.create_acl ? 1 : 0
  acl_name          = var.acl_name
  resource_group_id = var.resource_group_id
}

resource "alicloud_alb_listener" "alb_listener" {
  count                = var.create_listener ? 1 : 0
  load_balancer_id     = alicloud_alb_load_balancer.balancer.0.id
  listener_protocol    = var.listener_protocol
  listener_port        = var.listener_port
  listener_description = var.listener_description
  default_actions {
    type = var.default_action_type
    forward_group_config {
      server_group_tuples {
        server_group_id = local.server_group_id
      }
    }
  }
  acl_config {
    acl_type = var.acl_type
    acl_relations {
      acl_id = alicloud_alb_acl.alb_acl.0.id
    }
  }
}

resource "alicloud_ess_scaling_configuration" "ess_config" {
  count             = var.create_scaling_configuration ? 1 : 0
  scaling_group_id  = local.scaling_group_id
  image_id          = var.image_id
  instance_type     = var.instance_type
  security_group_id = var.security_group_id
  force_delete      = var.force_delete
  active            = var.active
  enable            = var.enable
}


resource "alicloud_ess_alb_server_group_attachment" "group_attachment" {
  count               = var.create_server_group_attachment ? 1 : 0
  scaling_group_id    = local.scaling_group_id
  alb_server_group_id = local.server_group_id
  port                = var.port
  weight              = var.weight
  force_attach        = var.force_attach
  depends_on          = [alicloud_ess_scaling_configuration.ess_config]
}