provider "aws" {
  region = var.region
}

# ---------------- VPC ----------------
module "vpc" {
  source = "../../module/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnets
  private_subnet_cidrs = var.private_subnets
  azs                  = var.azs
  project_name         = var.project_name
}

# ---------------- SECURITY GROUP ----------------
module "sg" {
  source = "../../module/security-group"

  name   = "${var.project_name}-sg"
  vpc_id = module.vpc.vpc_id
}

# ---------------- IAM ----------------
module "iam" {
  source = "../../module/iam"

  name = "${var.project_name}-role"
}

# ---------------- S3 ----------------
module "s3" {
  source = "../../module/s3"

  bucket_name = "${var.project_name}-bucket-dev"
}

# ---------------- EC2 ----------------
module "ec2" {
  source = "../../module/ec2"

  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = module.vpc.public_subnet_ids[0]
  sg_id           = module.sg.security_group_id
  iam_role        = module.iam.instance_profile
}

# ---------------- LOAD BALANCER ----------------
module "alb" {
  source = "../../module/load-balancer"

  name    = "${var.project_name}-alb"
  subnets = module.vpc.public_subnet_ids
  sg_id   = module.sg.security_group_id
}

# ---------------- RDS ----------------
module "rds" {
  source = "../../module/rds"

  username     = var.db_username
  password     = var.db_password
  sg_id        = module.sg.security_group_id
  subnet_group = module.vpc.private_subnet_ids
}

# ---------------- DYNAMODB ----------------
module "dynamodb" {
  source = "../../module/database_layer"

  name = "${var.project_name}-table"
}

# ---------------- LAMBDA ----------------
module "lambda" {
  source = "../../module/serverless_layer"

  name = "${var.project_name}-lambda"
  role = module.iam.lambda_role_arn
  file = "lambda.zip"
}

# ---------------- SQS ----------------
module "sqs" {
  source = "../../module/event_layer"

  name = "${var.project_name}-queue"
}

# ---------------- CLOUDWATCH ----------------
module "cw" {
  source = "../../module/monitoring & logging"

  name = "${var.project_name}-logs"
}

# ---------------- ROUTE53 ----------------
module "dns" {
  source = "../../module/dNS & routing"

  zone_id    = "ZXXXXXXXX"
  name       = "dev.example.com"
  lb_dns     = module.alb.dns_name
  lb_zone_id = module.alb.zone_id
}