resource "random_uuid" "bucket_uuid" {}

resource "aws_s3_bucket" "s3_storage" {
  bucket        = random_uuid.bucket_uuid.result
  force_destroy = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_key.arn
      }
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_policy" {
  bucket = aws_s3_bucket.s3_storage.id
  rule {
    id     = "transition-to-ia"
    status = "Enabled"

    filter {

    }

    transition {
      storage_class = "STANDARD_IA"
      days          = 30
    }
  }
}