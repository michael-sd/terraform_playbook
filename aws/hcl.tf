# Overview of Hashicorp Configuration Language (HCL)

# Used to configure a terraform project.
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Resource blocks are used to define the resources needed.
# resource "resource_type" "label"
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-sample-bucket"
}

# Data blocks are used to retrieve infrastructure that is
# not managed by us.
# data "resource_type" "label"
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

# We can define variables to be used similarly to function parameters.
variable "bucket_name" {
  type = string
  description = "My variable used to set the bucket name"
  default = "my_default_bucket_name"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# We can expose values to the outside world by defining an output block
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

# We can create temporary variables with a locals block
locals {
  local_example = "This is a local variable"
}

output "bucket_id" {
  value = local.local_example
}

# Modules are pieces of reusable code that we can import into our terraform project.
module "my_module" {
  # source from a folder within the terraform project
  source = "./module_example"
}