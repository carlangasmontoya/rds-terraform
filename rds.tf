
# Create a new Aurora Serverless PostgreSQL cluster
resource "aws_rds_cluster" "aurora_pg" {
  cluster_identifier      = "my-aurora-pg-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "14.6"
  database_name           = "my_database"
  master_username         = "my_username"
  master_password         = "my_password"
  backup_retention_period = 7 # in days
  preferred_backup_window = "00:00-01:00" # in UTC
  skip_final_snapshot     = true # set to false if you want a final snapshot before deleting the cluster
  
  # scaling_configuration {
  #   min_capacity = 2
  #   max_capacity = 16
  #   auto_pause   = true
  #   seconds_until_auto_pause = 300
  #   timeout_action = "ForceApplyCapacityChange"
  # }

  tags = {
    Name = "my-aurora-pg-cluster"
  }
}

# Create a new Aurora Serverless PostgreSQL database instance
resource "aws_rds_cluster_instance" "aurora_pg_instance" {
  count               = 2 # change the number of instances as desired
  cluster_identifier  = aws_rds_cluster.aurora_pg.id
  instance_class      = "db.t3.medium"
  identifier          = "my-aurora-pg-instance-${count.index}"
  engine              = "aurora-postgresql"
  publicly_accessible = false

  tags = {
    Name = "my-aurora-pg-instance-${count.index}"
  }
}



