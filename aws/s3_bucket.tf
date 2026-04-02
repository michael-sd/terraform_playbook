terraform {
  required_version = "1.14.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_bucket" "my_bucket" {
  bucket = "my_bucket_${random_id.bucket_suffix.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
