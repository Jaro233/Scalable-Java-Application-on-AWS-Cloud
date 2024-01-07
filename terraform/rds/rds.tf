provider "aws" {
  region = var.region
}

module "my_rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.3.0"

  identifier = "mydbinstance"
  engine     = "mysql"
  engine_version = "8.0"
  major_engine_version = "8.0"
  instance_class = var.db_instance_class
  allocated_storage = 20
  username = var.db_username
  password = var.db_password
  publicly_accessible = true
  manage_master_user_password = false

  subnet_ids              = var.subnet_ids
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  create_db_subnet_group  = true
  create_db_parameter_group = true
  create_db_option_group  = true
  family = "mysql8.0"
  db_name = "petclinic"
  parameter_group_name = "default-mysql8"
  skip_final_snapshot  = true
  backup_retention_period = 7
  multi_az               = false

  tags = {
    Name = "My RDS Instance"
  }
  # depends_on = [ aws_security_group.rds_sg ]
}

output "db_endpoint" {
  value = module.my_rds.db_instance_endpoint
}
