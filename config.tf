# S3 Bucket for Config
resource "aws_s3_bucket" "config_bucket" {
  bucket = "my-config-bucket-123456"  
}

# S3 Bucket for Config Delivery Channel
resource "aws_s3_bucket" "secure_config_bucket" {
  bucket = "my-secure-config-bucket"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Define the ACL using a separate aws_s3_bucket_acl resource
resource "aws_s3_bucket_acl" "config_bucket_acl" {
  bucket = aws_s3_bucket.config_bucket.bucket
  acl    = "private"
}

# IAM Role for AWS Config
resource "aws_iam_role" "config_role" {
  name = "config-role2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Effect    = "Allow"
      }
    ]
  })
}

# AWS Config Configuration Recorder (only one instance)
resource "aws_config_configuration_recorder" "example" {
  name     = "default"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

# AWS Config Delivery Channel (ensure this is unique and defined correctly)
resource "aws_config_delivery_channel" "example" {
  name           = "default"
  s3_bucket_name = aws_s3_bucket.config_bucket.bucket
}
