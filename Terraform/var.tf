variable "aws_region" {
    description = "AWS region to use"
    type        = string
    default     = "us-east-1" 
}

variable "bucket_name" {
    description = "Name of S3 bucket for recipebook"
    type        = string
    default     = "bellybrewrecipebook" 
}

