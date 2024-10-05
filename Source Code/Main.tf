# Create a VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

# Create a Subnet within the VPC

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Change if needed
  map_public_ip_on_launch = true

  tags = {
    Name = "MySubnet"
  }
}

# Create an S3 bucket

resource "aws_s3_bucket" "my_bucket" {
  bucket = "DevOps_855"  # Ensure the bucket name is globally unique

  tags = {
    Name = "MyBucket"
  }
}

# Create a security group for the EC2 instance

resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSSH"
  }
}

# Create RSA key of size 4096 bits for generating PEM file

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "TF_Key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh 
}

resource "local_file" "TF_Key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_name
}

# Create an EC2 instance

resource "aws_instance" "my_instance" {
  ami           = "ami-0fff1b9a61dec8a5f"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.allow_ssh.name]
  key_name = aws_key_pair.TF_Key.key_name
  tags = {
    Name = "MyInstance"
  }
}
