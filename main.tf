# Security Groups
resource "aws_security_group" "terraform_sg" {
  for_each = var.security_groups

  name_prefix = each.value.name_prefix
  description = each.value.description
  vpc_id      = each.value.vpc_id

  ingress {
    from_port   = each.value.ingress.from_port
    to_port     = each.value.ingress.to_port
    protocol    = each.value.ingress.protocol
    cidr_blocks = each.value.ingress.cidr_blocks
  }

  egress {
    from_port   = each.value.egress.from_port
    to_port     = each.value.egress.to_port
    protocol    = each.value.egress.protocol
    cidr_blocks = each.value.egress.cidr_blocks
  }
}

# Network ACLs
resource "aws_network_acl" "terraform_nacl" {
  for_each = var.net_acls

  vpc_id = each.value.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress

    content {
      protocol   = ingress.value.protocol
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
      action     = ingress.value.action
    }
  }

  dynamic "egress" {
    for_each = each.value.egress

    content {
      protocol   = egress.value.protocol
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
      action     = egress.value.action
    }
  }
}
