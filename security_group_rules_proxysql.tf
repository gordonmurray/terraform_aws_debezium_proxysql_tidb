resource "aws_security_group_rule" "proxysql_0" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.my_ip_address}/32"]
  security_group_id = aws_security_group.proxysql.id
  description       = "SSH egress"
}

resource "aws_security_group_rule" "proxysql_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.my_ip_address}/32"]
  security_group_id = aws_security_group.proxysql.id
  description       = "SSH ingress"
}
