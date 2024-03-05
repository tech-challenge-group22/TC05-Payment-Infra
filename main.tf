/*====
Variables used across all modules
======*/
locals {
  production_availability_zones = ["us-east-1a", "us-east-1b"]
}

provider "aws" {
  region  = "${var.region}"
}

terraform {
  backend "s3" {
    bucket         = "tc05-tfstate-payment"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}

module "networking" {
  source               = "./modules/networking"
  prefix               = "payment"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
  region               = "${var.region}"
  availability_zones   = "${local.production_availability_zones}"
  key_name             = "production_key"
}

module "rds" {
  source            = "./modules/rds"
  prefix       = "payment"
  allocated_storage = "10"
  database_name     = "${var.database_name}"
  database_username = "${var.database_username}"
  database_password = "${var.database_password}"
  subnet_ids        = module.networking.public_subnets_id
  vpc_id            = "${module.networking.vpc_id}"
  instance_class    = "db.t2.micro"
  depends_on = [
    module.networking
  ]
}

module sqs {
  source = "./modules/sqs"
}

module "ecs" {
  source              = "./modules/ecs"
  prefix         = "payment"
  vpc_id              = "${module.networking.vpc_id}"
  availability_zones  = "${local.production_availability_zones}"
  repository_name     = "payment/production"
  subnets_ids         = module.networking.private_subnets_id
  public_subnet_ids   = module.networking.public_subnets_id
  security_groups_ids = [
    module.networking.security_groups_ids,
    module.rds.db_access_sg_id
  ]
  database_endpoint   = "${module.rds.rds_address}"
  database_name       = "${var.database_name}"
  database_username   = "${var.database_username}"
  database_password   = "${var.database_password}"
  dbhost              = "${module.rds.rds_address}"
  execution_arn_role  = "${var.lab_role_arn}"
  rds_id              = "${module.rds.rds_id}"
  output_sqs_url       = "${module.sqs.output_sqs_url}"
  input_sqs_url        = "${var.input_sqs_url}"
  sqs_message_group    = "${var.sqs_message_group}"
  sqs_polling_interval = "${var.sqs_polling_interval}"
  secret_key_jwt_token = "${var.secret_key_jwt_token}"
  depends_on = [
    module.rds,
    module.networking
  ]
}
