resource "aws_rds_cluster" "aurora_cluster" {
  engine                         = var.engine
  engine_version                 = var.engine_version
  db_parameter_group_name     = var.db_parameter_group_name
  db_subnet_group_name           = var.db_subnet_group_name
  cluster_identifier             = var.cluster_identifier
  master_username                = var.master_username
  master_password                = var.master_password
  database_name                  = var.database_name
  backup_retention_period        = var.backup_retention_period
  copy_tags_to_snapshot          = var.copy_tags_to_snapshot
  deletion_protection            = var.deletion_protection

  dynamic "scaling_configuration" {
    for_each = var.capacity_type == "serverless" ? [1] : []
    content {
      auto_pause                = true
      min_capacity              = var.minimum_capacity_units
      max_capacity              = var.maximum_capacity_units
      seconds_until_auto_pause  = 300
    }
  }

  capacity_type = var.capacity_type == "serverless" ? "serverless" : null
  multi_az      = var.multi_az == true ? true : false

  dynamic "vpc_security_group_ids" {
    for_each = var.security_groups
    content {
      vpc_security_group_id = each.value
    }
  }

  dynamic "subnet_group" {
    for_each = var.subnet_ids
    content {
      subnet_identifier = each.value
    }
  }

  publicly_accessible = var.publicly_accessible == true ? true : false

  vpc_id = var.vpc_id
  instance_class = var.capacity_type != "serverless" ? var.instance_class : null
}
