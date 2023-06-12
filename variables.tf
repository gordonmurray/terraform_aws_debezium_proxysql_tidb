
variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_id" {
  type        = string
  description = "The VPC to use for your instances"
}

variable "subnets" {
  type        = list(any)
  description = "The subnets available in the VPC"
}

variable "default_tag" {
  type    = string
  default = "debezium_proxysql_tidb"
}

variable "my_ip_address" {
  type = string
}

variable "database_name" {
  type    = string
  default = "my-database"
}
