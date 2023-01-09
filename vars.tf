# S3 Bucket - new 
variable "documents_bucket_name" {

  type        = string
  description = "Required - Name of the s3 bucket."  
  default = "rawdatavalue001"  
}

variable "documents_bucket02_name" {

  type        = string
  description = "Required - Name of the s3 bucket."  
  default = "rawdatavalue002"  
}
variable "aws_region"{
    type = string
    description = "AWS region of bucket"
    default = "us-east-1"

}
  
#SQS 

variable "terraform_sqs_name" {
  type = string
  description = "Required name for SQS"
  default = "terraformSqs"

  
}

# SNS - Job notifications

variable "sns_notification_name" {
  type        = string
  description = "Required - Name of the sns notification topic"
  default = "sns_notification" 
}

# Lambda IAM Role
variable "Lambda_role_name" {
  type = string
  description = "Role name for lambda fucntion"
  default = "roleforlambda"
  
}

variable "Lambda_role_policy_name" {
  type = string
  description = "Provides write permissions to cloudWatch logs,Access Dynamodb, SQS, s3, and Textract"
  default = "Lambda_role_policy"
  
}

#lambda CloudWatch Log
variable "lambda_cloudwatch_log" {
  default = "lambda_cloudwatch_name"
}
