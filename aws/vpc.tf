# Basic infrastructure on AWS to create a Virtual Private Cloud (VPC) with two subnets,
# a public and a private one.
# Additionally creates an Internet gateway and a route table,
# which is associated with our public subnet.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform VPC"
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = "10.0.0.0/24"
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id           = aws_vpc.demo_vpc.id
  cidr_block       = "10.0.1.0/24"
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id           = aws_vpc.demo_vpc.id
}

# Create route table for public subnet
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate route table with public subnet
resource "aws_route_table_association" "public_subnet" {
  subnet_id         = aws_subnet.public_subnet.id
  route_table_id    = aws_route_table.public_rtb.id
}