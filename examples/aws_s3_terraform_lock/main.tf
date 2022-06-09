provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Terraform   = true
      Environment = "ENV_HERE"
      is_tflock = true
    }
  }
}

resource "aws_s3_bucket" "s3" {
  bucket = "NAME_HERE"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "s3" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "s3" {
  name = "NAME_HERE"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  # Despite using local it is my preference to use an s3 bucket and a dynamodb table for locking.
  backend "local" {
  }
}
