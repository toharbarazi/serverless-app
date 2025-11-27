provider "aws" {
    region = var.aws_region
}

resource "aws_s3_bucket" "bellybrew_recipe_book" {
  bucket = var.bucket_name

  object_ownership = "BucketOwnerEnforced"

  block_public_access {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  versioning {
    enabled = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  bucket_key_enabled = true
}


