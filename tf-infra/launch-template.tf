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

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      volume_type           = "gp2"
      encrypted             = true
      kms_key_id            = aws_kms_key.ec2_key.arn
      volume_size           = 25
    }
  }

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    HOST           = "${aws_db_instance.default.address}"
    DATABASE_NAME  = var.db_name
    DB_PASSWORD    = jsondecode(aws_secretsmanager_secret_version.db_password.secret_string)["password"]
    DB_PORT        = 3306
    S3_BUCKET_NAME = "${aws_s3_bucket.s3_storage.bucket}"
    DB_DIALECT     = var.database_engine
    SERVER_PORT    = 8080
    DB_USER        = var.db_username
    AWS_REGION     = var.region
  }))

  tags = {
    Name = "application-instance-${var.vpc_tag}"
  }
}
