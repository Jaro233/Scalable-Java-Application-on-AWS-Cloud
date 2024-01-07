locals {
  db_endpoint_without_port = split(":", module.my_rds.db_instance_endpoint)[0]
}

resource "null_resource" "db_setup" {
  depends_on = [module.my_rds]

  provisioner "local-exec" {
    command = "mysql -h ${local.db_endpoint_without_port} -u ${var.db_username} -p${var.db_password} -P 3306 petclinic < schema.sql"
  }
  provisioner "local-exec" {
    command = "mysql -h ${local.db_endpoint_without_port} -u ${var.db_username} -p${var.db_password} -P 3306 petclinic < data.sql"
  }
}