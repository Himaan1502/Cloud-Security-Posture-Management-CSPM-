# Provider Configuration
provider "aws" {
  region = "us-east-1" # Change to your preferred AWS region
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (replace with a valid AMI ID)
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-WebServer"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-bucket-123456" # Must be globally unique

  tags = {
    Name        = "SecureBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# RDS Instance
resource "aws_db_instance" "db_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.40"
  instance_class       = "db.t3.micro"
  db_name              = "mydatabase"
  username             = "admin"
  password             = "adminpassword" # Replace with a secure password
  publicly_accessible  = false

  tags = {
    Name = "Terraform-RDS"
  }
}

# IAM Role
resource "aws_iam_role" "example_role" {
  name = "example_iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "role_policy" {
  role = aws_iam_role.example_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Outputs
output "ec2_instance_id" {
  value = aws_instance.web_server.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.secure_bucket.bucket
}

output "rds_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}
