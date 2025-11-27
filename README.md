# terraform-alicloud-ess-alb
Terraform Module for creating scaling service for application load balancer on Alibaba Cloud.

These types of resources are supported:

* [alicloud_ess_scaling_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_group)
* [alicloud_ess_scaling_configuration](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_configuration)
* [alicloud_alb_load_balancer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer)
* [alicloud_alb_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_server_group)
* [alicloud_alb_acl](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_acl)
* [alicloud_alb_listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener)
* [alicloud_ess_alb_server_group_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_alb_server_group_attachment)


## Usage

<div style="display: block;margin-bottom: 40px;"><div class="oics-button" style="float: right;position: absolute;margin-bottom: 10px;">
  <a href="https://api.aliyun.com/terraform?source=Module&activeTab=document&sourcePath=terraform-alicloud-modules%3A%3Aess-alb&spm=docs.m.terraform-alicloud-modules.ess-alb&intl_lang=EN_US" target="_blank">
    <img alt="Open in AliCloud" src="https://img.alicdn.com/imgextra/i1/O1CN01hjjqXv1uYUlY56FyX_!!6000000006049-55-tps-254-36.svg" style="max-height: 44px; max-width: 100%;">
  </a>
</div></div>

```hcl
module "example" {
  source                         = "terraform-alicloud-modules/ess-alb/alicloud"
  create_scaling_group           = true
  create_balancer                = true
  create_listener                = true
  create_acl                     = true
  create_server_group            = true
  create_scaling_configuration   = true
  create_server_group_attachment = true
  min_size                       = 1
  max_size                       = 4
  scaling_group_name             = "your_scaling_group_name"
  removal_policies               = ["OldestInstance", "NewestInstance"]
  vswitch_ids                    = ["your_vswitch_id"]
  default_cooldown               = 20
  spot_instance_remedy           = false

  vpc_id                 = "your_vpc_id"
  address_type           = "Internet"
  address_allocated_mode = "Fixed"
  load_balancer_name     = "your_load_balancer_name"
  load_balancer_edition  = "Basic"
  zone_mappings = [
    { vswitch_id = "your_vswitch_1", zone_id = "your_zone_1" },
    { vswitch_id = "your_vswitch_2", zone_id = "your_zone_2" }
  ]
  access_log_config = [
    { log_project = "your_log_project_name", log_store = "your_log_store_name" }
  ]
  acl_name             = "your_acl_name"
  server_group_name    = "your_server_group_name"
  listener_port        = 80
  listener_description = "CreatedByTerraform"
  image_id             = "your_image_id"
  instance_type        = "instance_type"
  security_group_id    = "security_group_id"
  force_delete         = true
  active               = true
  enable               = true
  force_attach         = true
  port                 = 9000
  weight               = 50
}
```

## Examples

* [complete example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ess-alb/tree/main/examples/complete)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.160.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
MIT Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)