resource "aws_security_group" "kafka" {
  name        = "kafka"
  description = "Kafka cluster access"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.default_tag
  }
}

resource "aws_security_group" "rds" {
  name        = "rds"
  description = "rds access"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.default_tag
  }
}

resource "aws_security_group" "debezium" {
  name        = "debezium"
  description = "debezium instance access"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.default_tag
  }
}

resource "aws_security_group" "proxysql" {
  name        = "proxysql"
  description = "proxysql instance access"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.default_tag
  }
}