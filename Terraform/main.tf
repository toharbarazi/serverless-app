provider "aws" {
    region = var.aws_region
}

resource "aws_s3_bucket" "bellybrew_recipe_book" {
  bucket = var.bucket_name

  # הגדרת ניהול הגישה (ACL)
  object_ownership = "BucketOwnerEnforced"

  # חסימת גישה ציבורית
  block_public_access {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  # מצב גרסאות (Versioning) לא פעיל
  versioning {
    enabled = false
  }

  # הגדרת הצפנה
  server_side_encryption_configuration {
    rule {
      # הצפנה עם מפתחות S3
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # הגדרת מפתח ה-bucket
  bucket_key_enabled = true
}


