resource "aws_iam_instance_profile" "application_instance_profile" {
  name = "ApplicationInstanceProfile"
  role = aws_iam_role.s3_access_role.name
}

resource "aws_instance" "application_instance" {
  ami                         = var.custom_ami_id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.main_public_subnet[0].id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.application_sg.id]
  key_name                    = var.key_name
  depends_on                  = [aws_security_group.application_sg, aws_iam_role.s3_access_role, aws_iam_instance_profile.application_instance_profile]
  iam_instance_profile        = aws_iam_instance_profile.application_instance_profile.name

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }
  user_data = <<-EOT
    #!/bin/bash
      echo "HOST=${aws_db_instance.default.address}" | sudo tee /opt/csye6225/src/.env 
      echo "DATABASE_PORT=3306" | sudo tee -a /opt/csye6225/src/.env 
      echo "DATABASE_USERNAME=${var.db_username}" | sudo tee -a /opt/csye6225/src/.env 
      echo "DATABASE_PASSWORD=${var.db_password}" | sudo tee -a /opt/csye6225/src/.env
      echo "DATABASE_NAME=${var.db_name}" | sudo tee -a /opt/csye6225/src/.env 
      echo "DIALECT=${var.database_engine}" | sudo tee -a /opt/csye6225/src/.env 
      echo "PORT=8080" | sudo tee -a /opt/csye6225/src/.env 
      echo "BUCKET_NAME=${aws_s3_bucket.s3_storage.bucket}" | sudo tee -a /opt/csye6225/src/.env 
      sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cw-config.json -s
    EOT

  tags = {
    Name = "application-instance-${var.vpc_tag}"
  }
}