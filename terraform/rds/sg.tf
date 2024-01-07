resource "aws_security_group" "rds_sg" {
  name        = "my-rds-security-group"
  description = "Security group for RDS database instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306  # Default MySQL port
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}
