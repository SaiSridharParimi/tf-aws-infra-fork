resource "aws_launch_template" "application_launch_template" {
  name_prefix   = "csye6225-asg-"
  image_id      = var.custom_ami_id
  instance_type = "t3.micro"
  key_name      = var.key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.application_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.application_sg.id]
  }

  user_data = base64encode(<<-EOT
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
      sudo systemctl restart webapp.service
    EOT
  )

  tags = {
    Name = "application-instance-${var.vpc_tag}"
  }
}