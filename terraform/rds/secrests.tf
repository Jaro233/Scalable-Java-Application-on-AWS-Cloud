resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "dev-rds-db-4"
  # depends_on = [ module.my_rds ]
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
  # depends_on = [ module.my_rds ]
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name  = "/dev/petclinic/rds_endpoint"
  type  = "String"
  value = module.my_rds.db_instance_endpoint
  # depends_on = [ module.my_rds ]
}
