### Get VPC default

resource "aws_default_vpc" "default" {}


### Security Group 

resource "aws_security_group" "sg_test" {
  name        = "${lower(var.project)}-${lower(var.environment)}-sg"
  description = "Allow inbound traffic from ${var.cidr_blocks} on ports 22 and 80"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      description = "Allow traffic from ${var.cidr_blocks} on port ${ingress.value.from_port}"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = [var.cidr_blocks]
    }
  }

  ingress {
    description = "Allow port -1 for ping from ${var.cidr_blocks}"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_blocks]
  }

  tags = {
    Name         = "${lower(var.project)}-${lower(var.environment)}-sg"
    Organization = "${lower(var.organization_name)}"
    Environment  = "${lower(var.environment)}"
    Project      = "${lower(var.project)}"
    ManagedBy    = "terraform"
  }
}
