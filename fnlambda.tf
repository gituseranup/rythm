#Lambda IAM Role and Policy 
resource "aws_iam_role" "lambda_role" {
    name = var.Lambda_role_name
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"Service": "lambda.amazonaws.com"
			},
			"Action": "sts:AssumeRole"
		}
	]
}
 EOF 
}
#Policy
resource "aws_iam_policy" "lambda_role_policy" {
	name        = var.Lambda_role_policy_name
	description = "Provides write permissions to CloudWatch Logs, Access Dynamodb, SQS, s3, and Textract"
	path        = "/"
	policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "",
			"Effect": "Allow",
			"Action": [
				"lambda:*",
				"logs:*",
				"sqs:*",
				"textract:*",
				"dynamodb:*",
				"s3:*"
			],
			"Resource": "*"
		}
	]
}
EOF
}
#Lambda Function
resource "aws_lambda_function" "lambda" {
  function_name = "hello_lambda"

  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"

  role    = "${aws_iam_role.lambda_role.arn}"
  handler = "hellopy.lambda_handler"
  runtime = "python3.7"

  environment {
    variables = {
      greeting = "Hello"
    }
  }
}

