resource "aws_security_group" "database_security_group" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.application_sg.id]
  }

  tags = {
    Name = "db-security-group"
  }
}