resource "aws_s3_bucket" "raw_data_bucket1" {
  bucket = var.documents_bucket_name
  force_destroy = true

  tags = {
    Name = var.documents_bucket_name
    region= var.aws_region

  }
}

resource "aws_s3_bucket_acl" "salesforce-aws-data-bucket" {
  bucket = aws_s3_bucket.raw_data_bucket1.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_enable" {
  bucket = aws_s3_bucket.raw_data_bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}


/*
#Second bucket of data
resource "aws_s3_bucket" "raw_data_bucket2" {
  bucket = var.documents_bucket02_name
  force_destroy = true

  tags = {
    Name = var.documents_bucket02_name
    region= var.aws_region

  }
}

resource "aws_s3_bucket_acl" "bucket2" {
  bucket = aws_s3_bucket.raw_data_bucket2.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_enable" {
  bucket = aws_s3_bucket.raw_data_bucket2.id
  versioning_configuration {
    status = "Enabled"
  }
}

*/