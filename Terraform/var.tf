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

