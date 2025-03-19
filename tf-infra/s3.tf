resource "random_uuid" "bucket_uuid" {}

resource "aws_s3_bucket" "s3_storage" {
  bucket        = random_uuid.bucket_uuid.result
  force_destroy = true
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