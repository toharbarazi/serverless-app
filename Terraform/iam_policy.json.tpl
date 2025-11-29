{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }, {
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem"
            ],
            "Resource": "${dynamodb_table_arn}"
        }, {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "${books_bucket_arn}/books/*"
        }, {
            "Effect": "Allow",
            "Action": [
                "ses:SendEmail"
            ],
            "Resource": "*"
        }
    ]
}