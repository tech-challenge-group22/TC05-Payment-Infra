variable "region" {
  description = "Region that the instances will be created"
}

/*====
environment specific variables
======*/

variable "database_name" {
  description = "The database name for Production"
}

variable "database_username" {
  description = "The username for the Production database"
}

variable "database_password" {
  description = "The user password for the Production database"
}

variable "lab_role_arn" {
  description = "The lab role"
}

variable "payment_queue_received" {
}

variable "payment_queue_processed" {
}

variable "sqs_message_group" {
}

variable "sqs_polling_interval" {
}

variable "secret_key_jwt_token" {
}
