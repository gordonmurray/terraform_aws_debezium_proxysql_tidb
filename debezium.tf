data "aws_ami" "debezium" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debezium*"]
  }

  owners = [var.aws_account_id]
}

resource "aws_instance" "debezium" {
  ami                     = data.aws_ami.debezium.id
  instance_type           = "t4g.small"
  key_name                = aws_key_pair.key.key_name
  subnet_id               = var.subnets[0]
  vpc_security_group_ids  = [aws_security_group.debezium.id]
  disable_api_termination = true

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "100"

    tags = {
      Name = var.default_tag
    }
  }

  tags = {
    Name = "Debezium"
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  user_data = templatefile("files/user_data.sh", {
    brokers = aws_msk_cluster.kafka.bootstrap_brokers
  })

}
