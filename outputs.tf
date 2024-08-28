output "scaling_group_id" {
  description = "The Scaling Group ID"
  value       = concat(alicloud_ess_scaling_group.scaling_group[*].id, [""])[0]
}

output "balancer_id" {
  description = "The Application Load Balancer (ALB) Balancer ID"
  value       = concat(alicloud_alb_load_balancer.balancer[*].id, [""])[0]
}

output "listener_id" {
  description = "The Application Load Balancer (ALB) Listener ID"
  value       = concat(alicloud_alb_listener.alb_listener[*].id, [""])[0]
}

output "server_group_id" {
  description = "The Application Load Balancer (ALB) Server Group ID"
  value       = concat(alicloud_alb_server_group.alb_server_group[*].id, [""])[0]
}

output "alb_acl_id" {
  description = "The Application Load Balancer (ALB) Acl ID"
  value       = concat(alicloud_alb_acl.alb_acl[*].id, [""])[0]
}

output "ess_config_id" {
  description = "The ESS scaling configuration"
  value       = concat(alicloud_ess_scaling_configuration.ess_config[*].id, [""])[0]
}