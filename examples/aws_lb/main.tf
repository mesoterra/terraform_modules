provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Environment = "dev"
      Terraform   = true
    }
  }
}

locals {
  lb = [
    {
      name = "ALB01"
      internal = false
      load_balancer_type = "application"
      security_groups = ["sg-ID_HERE"]
      subnets = ["subnet-ID_HERE", "subnet-ID_HERE"]
      enable_deletion_protection = false
      access_logs = {
        bucket = "NAME_HERE"
        prefix = "alb01-access-logs"
        enabled = false
      }
    },
    {
      name = "NLB01"
      internal = false
      load_balancer_type = "network"
      security_groups = ["sg-ID_HERE"]
      subnets = ["subnet-ID_HERE", "subnet-ID_HERE"]
      enable_deletion_protection = false
      access_logs = {
        bucket = "NAME_HERE"
        prefix = "nlb01-access-logs"
        enabled = false
      }
    },
    {
      name = "GATEWAY01"
      internal = false
      load_balancer_type = "gateway"
      security_groups = ["sg-ID_HERE"]
      subnets = ["subnet-ID_HERE", "subnet-ID_HERE"]
      enable_deletion_protection = false
      access_logs = {
        bucket = "NAME_HERE"
        prefix = "gateway01-access-logs"
        enabled = false
      }
    },
  ]
}

module "test" {
  source = "../../terraform_modules/aws/lb/"
  lb = local.lb
}

#output "debug" {
#  value = module.test.debug
#}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
  backend "s3" {
    bucket = "NAME_HERE"
    key = "tflock/terraform.tfstate"
    region = "us-east-2"
  }
}
