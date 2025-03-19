resource "aws_db_parameter_group" "db_pg" {
  name   = "custom-db-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = flatten([for subnet in aws_subnet.main_private_subnet : subnet.id])

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  identifier             = var.db_instance_identifier
  db_name                = var.db_name
  engine                 = var.database_engine
  engine_version         = var.db_engine_version
  instance_class         = var.instance_class
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = aws_db_parameter_group.db_pg.name
  db_subnet_group_name   = aws_db_subnet_group.default.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  publicly_accessible    = false
  multi_az               = false
}