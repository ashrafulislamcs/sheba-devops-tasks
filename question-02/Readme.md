Highly Available System on AWS
This guide outlines the setup of a highly available system on AWS with a web application and a database. The web app is hosted on EC2 instances, and the database is hosted on Amazon RDS in a private subnet.

Architecture Overview
Web Application Tier:
Hosted on EC2 instances.
Publicly accessible via a Load Balancer.
Scales automatically based on traffic.

Database Tier:
Managed by Amazon RDS in a private subnet.
Multi-AZ deployment for high availability.

Prerequisites
AWS Account
IAM User with permissions for EC2, RDS, VPC, Load Balancers, and Auto Scaling Groups.
Terraform installed locally.
Setup Instructions

1. Networking
VPC: Create a VPC with a CIDR block (e.g., 10.0.0.0/16).

Subnets:
Public subnets for the web app.
Private subnets for RDS.
Internet Gateway: Attach to the VPC for internet access.

Route Tables:
Public subnets route through the Internet Gateway.
Private subnets have no internet access.

2. Web Application Tier
Security Group:
Allow HTTP (80) and HTTPS (443) traffic.
Allow outbound traffic to the database port (e.g., 5432).
Load Balancer: Distribute traffic to EC2 instances.

Auto Scaling Group:

Launch EC2 instances with a template.
Scale based on CPU usage or traffic.

3. Database Tier
RDS Instance:
Deploy in a private subnet.
Enable Multi-AZ for high availability.
Security group allows access only from the web app.

4. Testing and Validation
Web App:
Access via Load Balancer DNS.
Verify scaling with load.

Database:
Ensure web app connectivity to RDS.


Finally this setup provides a scalable and highly available system on AWS, utilizing managed services for performance and reliability.

