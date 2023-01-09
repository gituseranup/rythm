resource "aws_sqs_queue" "terraform_queue" {
  name = var.terraform_sqs_name
  

  tags = {
    Environment = "production"
    region = var.aws_region
  }
}

# AWS SQS Queue Policy
resource "aws_sqs_queue_policy" "sync_queue" {
  queue_url             =  aws_sqs_queue.terraform_queue.id
  policy                = <<POLICY
{
  "Version" : "2012-10-17",
  "Id" : "sqspolicy",
  "Statement" : [
    {
      "Sid" : "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:*",
      "Resource": "${aws_sqs_queue.terraform_queue.arn}"
    }
  ]   
}
POLICY
}


#SNS 
resource "aws_sns_topic" "sns_notification" {
  name = var.sns_notification_name
  tags = {
    region = var.aws_region
  }
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

# SNS topic subscription

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns_notification.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.terraform_queue.arn
}