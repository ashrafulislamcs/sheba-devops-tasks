provider "aws" {
  region = "ap-southeast-1" # Singapore region
}

resource "aws_instance" "sheba-test" {
  ami                         = "ami-0b1deee7529c7f708"
  instance_type               = "t4g.micro"
  associate_public_ip_address = true

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 12 # 12 GB boot disk
    volume_type = "gp2"
  }

  tags = {
    Name = "sheba-test-instance"
  }

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y aws-cli
                EOF

  iam_instance_profile = aws_iam_instance_profile.s3_access.name
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "s3_access" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name = "ec2_s3_access_policy"
  role = aws_iam_role.s3_access.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "s3_access" {
  name = "ec2_s3_access_profile"
  role = aws_iam_role.s3_access.name
}
