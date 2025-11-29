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

############################################
# S3 Bucket
############################################
resource "aws_s3_bucket" "bellybrew_recipe_book" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bellybrew_recipe_book_encryption" {
  bucket = aws_s3_bucket.bellybrew_recipe_book.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bellybrew_recipe_book_block" {
  bucket = aws_s3_bucket.bellybrew_recipe_book.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "recipebook_upload" {
  bucket = aws_s3_bucket.bellybrew_recipe_book.bucket
  key    = "books/book.pdf"
  source = var.book_source
  acl    = "private"
}

############################################
# DynamoDB Table
############################################
resource "aws_dynamodb_table" "profile_table" {
  name         = var.dyanmoDB_table_name
  hash_key     = "Email"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Email"
    type = "S"
  }
}

############################################
# SES Email Identity
############################################
resource "aws_ses_email_identity" "from_email" {
  email = var.ses_from_email_address
}

############################################
# Lambda IAM Role
############################################
resource "aws_iam_role" "lambda_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "lambda.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

############################################
# Generate IAM Policy From Template
############################################
locals {
  policy_json = templatefile(
    "${path.module}/iam_policy.json.tpl",
    {
      dynamodb_table_arn = aws_dynamodb_table.profile_table.arn
      books_bucket_arn   = aws_s3_bucket.bellybrew_recipe_book.arn
    }
  )
}

resource "aws_iam_policy" "lambda_policy" {
  name   = var.iam_policy_name
  policy = local.policy_json
}

############################################
# Attach Policy → Role
############################################
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
