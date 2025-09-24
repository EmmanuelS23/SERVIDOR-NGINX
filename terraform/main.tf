terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Obtener el VPC por defecto de la región
data "aws_vpc" "default" {
  default = true
}

# Security group con acceso SSH y HTTP
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = "vpc-0bc939ba5dbdd6154"  

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}


resource "aws_instance" "web" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t3.micro"
  key_name               = "terraform-key"   
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Servidor-Nginx"
  }
}

# Output de la IP pública
output "public_ip" {
  description = "La IP pública de la instancia"
  value       = aws_instance.web.public_ip
}
