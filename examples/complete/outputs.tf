output "scaling_group_id" {
  description = "The Scaling Group ID"
  value       = module.ess-alb.scaling_group_id
}

output "balancer_id" {
  description = "The Application Load Balancer (ALB) Balancer ID"
  value       = module.ess-alb.balancer_id
}

output "listener_id" {
  description = "The Application Load Balancer (ALB) Listener ID"
  value       = module.ess-alb.listener_id
}

output "server_group_id" {
  description = "The Application Load Balancer (ALB) Server Group ID"
  value       = module.ess-alb.server_group_id
}

output "alb_acl_id" {
  description = "The Application Load Balancer (ALB) Acl ID"
  value       = module.ess-alb.alb_acl_id
}

output "ess_config_id" {
  description = "The ESS scaling configuration"
  value       = module.ess-alb.ess_config_id
}
