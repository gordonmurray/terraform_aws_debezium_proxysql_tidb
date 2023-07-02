resource "aws_security_group_rule" "rds_1" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.debezium.id
  security_group_id        = aws_security_group.rds.id
  description              = "Allow ingress to Debezium instance"
}

resource "aws_security_group_rule" "rds_2" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.proxysql.id
  security_group_id        = aws_security_group.rds.id
  description              = "Allow ingress to ProxySQL instance"
}
