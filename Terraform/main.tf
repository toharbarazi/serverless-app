terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "bellybrew_recipe_book" {
  bucket = var.bucket_name

  # הגדרות נוספות עבור ה-S3 bucket
}

# הגדרת הצפנה בשרת (Server-Side Encryption) ב-resource נפרד
resource "aws_s3_bucket_server_side_encryption_configuration" "bellybrew_recipe_book_encryption" {
  bucket = aws_s3_bucket.bellybrew_recipe_book.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# הגדרת הגבלות גישה ציבורית באמצעות resource נפרד
resource "aws_s3_bucket_public_access_block" "bellybrew_recipe_book_block" {
  bucket = aws_s3_bucket.bellybrew_recipe_book.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "recipebook_upload" {
  bucket                 = aws_s3_bucket.bellybrew_recipe_book.bucket
  key                    = "books/book.pdf"
  source                 = var.book_source
  acl                    = "private"  # גישת ה-ACL
}
