resource "aws_securityhub_account" "example" {
  # Enabling Security Hub for your AWS account
}

resource "aws_securityhub_standards_subscription" "cis_aws_foundations" {
  # Enable CIS AWS Foundations Benchmark
  standards_arn = "arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/1.2.0"
}

resource "aws_guardduty_detector" "example" {
  enable = true
}

resource "aws_cloudtrail" "example" {
  name                          = "example-cloudtrail"
  s3_bucket_name                = "your-cloudtrail-s3-bucket"
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  include_global_service_events = true
}

resource "aws_config_configuration_recorder" "example1" {
  name        = "default"
  role_arn    = aws_iam_role.config_role.arn
  recording_group {
    all_supported = true
  }
}

resource "aws_config_config_rule" "example" {
  name = "example-rule"
  source {
    owner             = "AWS"
    source_identifier = "CLOUDWATCH_ALARM"
  }
}

resource "aws_iam_role" "config_role1" {
  name = "config_role1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
      },
    ]
  })
}
