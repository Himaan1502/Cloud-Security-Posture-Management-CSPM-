# Cloud Security-Posture Management CSPM
Cloud Security Posture Management (CSPM) Using Terraform and AWS Security Hub.

## Terraform AWS Infrastructure Setup

This project provisions an AWS infrastructure using Terraform. It creates various resources such as an S3 bucket, RDS database, security configurations, and more. The configuration file (`main.tf`) defines all the necessary resources and dependencies.

## Prerequisites

Ensure the following tools and configurations are in place before proceeding:

1. **Terraform**: Install [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) on your machine.
2. **AWS CLI**: Install and configure [AWS CLI](https://aws.amazon.com/cli/) with credentials and a default region.
3. **IAM Permissions**: Your AWS user must have sufficient permissions to create the resources, such as:
   - S3
   - RDS
   - Lambda
   - Config Service
   - Security Hub
   - GuardDuty
4. **Terraform Provider**: Ensure you have the AWS Terraform provider configured.

## Resources Provisioned

The following resources are defined in `main.tf`:

1. **S3 Bucket**
   - Bucket for storing configuration data.
   - Versioning and access control are applied.

2. **RDS Database**
   - Subnet group and instance for relational database storage.
   - Security and access configurations.

3. **AWS Config**
   - Tracks resource configurations and compliance status.

4. **Security Hub**
   - Enables AWS Security Hub for centralized security management.

5. **GuardDuty**
   - Configures GuardDuty for threat detection.

6. **Lambda**
   - A sample Lambda function for automated remediation tasks.

7. **SNS Topic**
   - For sending alerts and notifications.

## Files in This Project

- **`main.tf`**: Terraform configuration file defining the resources.



