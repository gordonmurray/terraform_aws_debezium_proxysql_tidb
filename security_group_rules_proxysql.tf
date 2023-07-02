resource "aws_security_group_rule" "proxysql_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.my_ip_address}/32"]
  security_group_id = aws_security_group.proxysql.id
  description       = "SSH ingress"
}

resource "aws_security_group_rule" "proxysql_rds" {
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds.id
  security_group_id        = aws_security_group.proxysql.id
  description              = "ProxySQL egress to RDS"
}

resource "aws_security_group_rule" "proxysql_tidb" {
  type              = "egress"
  from_port         = 4000
  to_port           = 4000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.proxysql.id
  description       = "ProxySQL egress to TiDB"
}

resource "aws_security_group_rule" "proxysql_open" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${var.my_ip_address}/32"]
  security_group_id = aws_security_group.proxysql.id
  description       = "ProxySQL ingress for my IP address"
}