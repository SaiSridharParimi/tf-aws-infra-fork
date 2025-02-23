resource "aws_instance" "application_instance" {
  ami                         = var.custom_ami_id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.main_public_subnet[0].id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.application_sg.id]
  key_name                    = var.key_name
  depends_on = [aws_security_group.application_sg]

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
      Name = "application-instance-${var.vpc_tag}"
}
}