provider "alicloud" {
  region = "cn-shanghai"
}
data "alicloud_alb_zones" "default" {}
data "alicloud_images" "default" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}
data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones[3].id
}
resource "random_integer" "rand" {
  min = 1
  max = 50000
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_vswitch" "vswitch_1" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = cidrsubnet(alicloud_vpc.default.cidr_block, 8, 2)
  zone_id      = data.alicloud_alb_zones.default.zones.3.id
  vswitch_name = var.vswitch_name_1
}

resource "alicloud_vswitch" "vswitch_2" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = cidrsubnet(alicloud_vpc.default.cidr_block, 8, 4)
  zone_id      = data.alicloud_alb_zones.default.zones.4.id
  vswitch_name = var.vswitch_name_2
}

resource "alicloud_security_group" "default" {
  name   = "tf-testacc"
  vpc_id = alicloud_vpc.default.id
}


resource "alicloud_log_project" "default" {
  project_name = "${var.log_project_name}-${random_integer.rand.result}"
  description  = "created by terraform"
}

resource "alicloud_log_store" "default" {
  project_name          = alicloud_log_project.default.project_name
  logstore_name         = "${var.log_store_name}-${random_integer.rand.result}"
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

module "ess-alb" {
  source                         = "../.."
  create_scaling_group           = true
  create_balancer                = true
  create_listener                = true
  create_acl                     = true
  create_server_group            = true
  create_scaling_configuration   = true
  create_server_group_attachment = true
  min_size                       = var.min_size
  max_size                       = var.max_size
  scaling_group_name             = var.scaling_group_name
  removal_policies               = var.removal_policies
  vswitch_ids                    = [alicloud_vswitch.vswitch_1.id, alicloud_vswitch.vswitch_2.id]
  default_cooldown               = var.default_cooldown
  spot_instance_remedy           = var.spot_instance_remedy

  vpc_id                 = alicloud_vpc.default.id
  address_type           = "Internet"
  address_allocated_mode = "Fixed"
  load_balancer_name     = var.load_balancer_name
  load_balancer_edition  = "Basic"
  zone_mappings = [
    { vswitch_id = alicloud_vswitch.vswitch_1.id, zone_id = alicloud_vswitch.vswitch_1.zone_id },
    { vswitch_id = alicloud_vswitch.vswitch_2.id, zone_id = alicloud_vswitch.vswitch_2.zone_id }
  ]
  access_log_config = [
    { log_project = alicloud_log_project.default.project_name, log_store = alicloud_log_store.default.logstore_name }
  ]
  acl_name             = var.acl_name
  server_group_name    = var.server_group_name
  listener_port        = 80
  listener_description = "CreatedByTerraform"
  image_id             = data.alicloud_images.default.images[0].id
  instance_type        = data.alicloud_instance_types.default.instance_types[0].id
  security_group_id    = alicloud_security_group.default.id
  force_delete         = var.force_delete
  active               = var.active
  enable               = var.enable
  force_attach         = var.force_attach
  port                 = 9000
  weight               = 50
}
