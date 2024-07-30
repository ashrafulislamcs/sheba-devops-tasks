Terraform AWS EC2 Setup
This Terraform script sets up an EC2 instance in the Singapore region with specific attributes of question one. The instance is configured to have full access to S3, allowing read/write operations.

Prerequisites
Before you begin, ensure you have the following installed on your machine:

Terraform: install the terraform
AWS CLI: Download and install AWS CLI.
AWS CLI Configuration
After installing the AWS CLI, configure it with your AWS credentials. Run the following command and provide your access key, secret key, default region (e.g., ap-southeast-1 for Singapore), and default output format:

# aws configure

# terraform init

# terraform plan

# terraform plan

# terraform destory (to destroy the created resouces)
