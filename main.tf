//This is the code for vpc 

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"  // class B 65k

  tags = {
    Name = "Terraform-Vpc"
    env = "Dev"
  }
}

// internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "Terraform-IGW"
  }
}

// subnet creation
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"  // class c  254 ips 
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform-public-sub1"
  }
}
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"  // class c  254 ips 
  availability_zone = "us-east-1b"

  tags = {
    Name = "Terraform-public-sub2"
  }
}

// subnet creation private
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.3.0/24"  // class c  254 ips 
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform-private-sub1"
  }
}
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.4.0/24"  // class c  254 ips 
  availability_zone = "us-east-1b"

  tags = {
    Name = "Terraform-private-sub2"
  }
}

// security group

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group with TCP ports 22, 80, and 8080 open"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow custom app on port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}
