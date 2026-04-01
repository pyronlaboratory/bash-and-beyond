provider "aws" {
  region = var.region
}

# ── Look up existing resources (no new infra created) ──────────────────────────

data "aws_subnet" "existing" {
  id = var.subnet_id
}

data "aws_security_group" "guardians" {
  count = var.create_new_sg ? 0 : 1
  id    = var.security_group_id
}

resource "aws_security_group" "new_sg" {
  count  = var.create_new_sg ? 1 : 0
  name   = "guardians-of-the-port"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.local_ip]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  security_group_id = var.create_new_sg ? aws_security_group.new_sg[0].id : data.aws_security_group.guardians[0].id
}

# ── EC2 Instance ───────────────────────────────────────────────────────────────

resource "aws_instance" "terra_byte" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.existing.id
  vpc_security_group_ids      = [local.security_group_id]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    encrypted             = false

    # Boots from the same snapshot as your previous instance
    # so you get an identical starting disk state.

    # Remove this line if you want a clean volume from the AMI instead.
    # snapshot_id           = var.snapshot_id
  }

  tags = {
    Name = "terra-byte"
  }
}
