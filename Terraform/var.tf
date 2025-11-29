variable "aws_region" {
    description = "AWS region to use"
    type        = string
    default     = "us-east-1" 
}

variable "bucket_name" {
    description = "Name of S3 bucket for recipebook"
    type        = string
    default     = "bellybrewrecipebook-tohar" 
}

variable "book_source" {
    description = "file location"
    type        = string
    default     = "../recipebook/book.pdf" 
}
variable "dyanmoDB_table_name" {
    description = "the table name for the DB"
    type        = string
    default     = "ProfileTableTohar" 
}

variable "ses_from_email_address" {
  description = "The email address to use as the SES identity"
  type        = string
  default     = "toharbarazi@gmail.com"
}

variable "iam_policy_name" {
  type        = string
  description = "The name for the IAM policy"
  default     = "bellybrew_policy"
}

variable "iam_role_name" {
  type        = string
  description = "The name for the IAM role"
  default     = "bellybrew_role"
}

variable "lambda_name" {
  type        = string
  description = "The name for the lambda funtion"
  default     = "bellybrew_function"
}

variable "lambda_code_filename" {
  type        = string
  description = "Path to the Lambda code .zip file"
  default     = "./lambda_function.zip"
}

variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "bellybrew-api"
}
