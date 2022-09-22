provider "aws" {
  region = "ap-northeast-1"
}

data "aws_availability_zones" "available" {}

variable "project" {
  default = "eks"
}

variable "environment" {
  default = "dev"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "num_subnets" {
  default = 2
}

locals {
  base_tags = {
    Project     = var.project
    Terraform   = true
    Environment = var.environment
  }
  default_tags = merge(local.base_tags, tomap({ "kubernetes.io/cluster/${local.cluster_name}" = "shared" }))
  base_name    = "${var.project}-${var.environment}"
  cluster_name = "${local.base_name}-cluster"
}