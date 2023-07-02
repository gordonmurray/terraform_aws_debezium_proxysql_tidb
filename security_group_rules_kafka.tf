resource "aws_security_group_rule" "kafka_in" {
  type                     = "ingress"
  from_port                = 9092
  to_port                  = 9092
  protocol                 = "tcp"
  security_group_id        = aws_security_group.kafka.id
  source_security_group_id = aws_security_group.debezium.id
  description              = "Kafka brokers ingress"
}

resource "aws_security_group_rule" "kafka_out" {
  type                     = "egress"
  from_port                = 9092
  to_port                  = 9092
  protocol                 = "tcp"
  security_group_id        = aws_security_group.kafka.id
  source_security_group_id = aws_security_group.debezium.id
  description              = "Kafka brokers egress"
}
