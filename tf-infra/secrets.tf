resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "aws_secretsmanager_secret" "db_password_secret" {
  name        = "db-password-a8-v4" #change
  description = "RDS instance DB password stored by Terraform"
  kms_key_id  = aws_kms_key.secrets_manager_key.arn
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password_secret.id
  secret_string = jsonencode({ password = random_password.db_password.result })
}

resource "aws_iam_policy" "secrets_access_policy" {
  name        = "SecretsManagerAccessPolicy"
  description = "Allows EC2 to get secret value and decrypt it with KMS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = aws_iam_policy.secrets_access_policy.arn
}