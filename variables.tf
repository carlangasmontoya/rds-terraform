variable "engine" {
  description = "The name of the database engine to be used for the RDS instance. This value must be postgres"
  type        = string
}

variable "capacity_type" {
  description = "The capacity type of the Aurora Serverless DB cluster"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine to be used for the RDS instance"
  type        = string
}

variable "cluster_identifier" {
  description = "The name of the DB cluster"
  type        = string
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "minimum_capacity_units" {
  description = "The minimum number of Aurora capacity units (ACUs) to be allocated to the DB cluster"
  type        = number
}

variable "maximum_capacity_units" {
  description = "The maximum number of Aurora capacity units (ACUs) to be allocated to the DB cluster"
  type        = number
}

variable "multi_az" {
  description = "Specifies whether the DB cluster should have a secondary cluster in a different Availability Zone"
  type        = bool
}

variable "vpc_id" {
  description = "The ID of the VPC in which to launch the RDS instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to associate with the DB instance"
  type        = string
}

variable "publicly_accessible" {
  description = "Specifies whether the DB instance should have a publicly accessible IP address"
  type        = bool
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the DB instance"
  type        = list(string)
}

variable "database_name" {
  description = "The name of the initial database to be created when the DB instance is created"
  type        = string
}

variable "db_parameter_group_name" {
  description = "The name of the DB parameter group to associate with this DB instance"
  type        = string
}

variable "backup_retention_period" {
  description = "The number of days for which automated backups are retained"
  type        = number
}

variable "copy_tags_to_snapshot" {
  description = "Specifies whether to copy all tags from the DB cluster to snapshots of the DB cluster"
  type        = bool
}

variable "deletion_protection" {
  description = "Specifies whether to enable deletion protection for the DB instance"
  type        = bool
}

variable "subnet_ids" {
  type        = set(string)
  description = "List of subnet IDs for the RDS instance"
}

variable "scaling_configuration" {
  description = "Configuration for cluster scaling"
  type = object({
    auto_pause = bool
    max_capacity = number
    min_capacity = number
    seconds_until_auto_pause = number
    timeout_action = string
  })
  default = {
    auto_pause = true
    max_capacity = 4
    min_capacity = 1
    seconds_until_auto_pause = 300
    timeout_action = "ForceApplyCapacityChange"
  }
}
