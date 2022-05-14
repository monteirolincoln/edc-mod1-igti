resource "aws_iam_role" "lambda" {
  name = "IGTILambdaRole"

  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal":{
              "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": "AssumeRole"
        }
    ]  
}
EOF

    tags = {
        IES = "IGTI"
        CURSO = "EDC"
    }
}

resource "aws_iam_policy" "name" {
  name = "IGTIAWSLambdaBasicExecutionRolePolicy"
  path = "/"
  description = "Provides write permissions to CloudMatch Logs, S3 buckets and EMR Steps"

  policy = <<EOF
{
    "Version": "2012-10-17"
    "Statement":[
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStram",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticmapreduce:*"
            ],
            "Resource": "*"
        },
        {
            "Action": "iam:PassRole",
            "Resource": ["arn:aws:iam::002086524290:role/EMR_DefaultRole",
                		 "arn:aws:iam::002086524290:role/EMR_EC2_DefaultRole"],
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}