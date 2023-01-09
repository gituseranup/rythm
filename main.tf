terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws"{
    region="${var.aws_region}"
}
provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "hellopy.py"
  output_path = "hellopy.zip"
}
