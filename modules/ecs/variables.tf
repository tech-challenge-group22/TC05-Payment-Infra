variable "prefix" {
  description = "The prefix"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "availability_zones" {
  type        = list(string)
  description = "The azs to use"
}

variable "security_groups_ids" {
  description = "The SGs to use"
}

variable "subnets_ids" {
  type    = list(string)
  description = "The private subnets to use"
}

variable "public_subnet_ids" {
  description = "The private subnets to use"
}

variable "database_endpoint" {
  description = "The database endpoint"
}

variable "database_username" {
  description = "The database username"
}

variable "database_password" {
  description = "The database password"
}

variable "database_name" {
  description = "The database that the app will use"
}

variable "execution_arn_role" {
  description = "arn of execution role"
}

variable "dbhost" {
  description = "dbhost"
}

variable "rds_id" {
  description = "dbhost"
}

variable "payment_queue_processed" {
  description = "SQS Payment response"
}

variable payment_queue_received {
  description = "SQS url to receive events"
}

variable sqs_polling_interval {
}

variable sqs_message_group {
}

variable secret_key_jwt_token {
}

variable "ecr_url" {
}
