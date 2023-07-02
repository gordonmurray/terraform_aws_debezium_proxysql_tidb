
resource "aws_security_group_rule" "debezium_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.my_ip_address}/32"]
  security_group_id = aws_security_group.debezium.id
  description       = "SSH ingress"
}

resource "aws_security_group_rule" "debezium_msk" {
  type                     = "egress"
  from_port                = 9092
  to_port                  = 9092
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kafka.id
  security_group_id        = aws_security_group.debezium.id
  description              = "MSK Kafka egress"
}

resource "aws_security_group_rule" "debezium_rds" {
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds.id
  security_group_id        = aws_security_group.debezium.id
  description              = "Debezium egress to RDS"
}