resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags

  dynamic ingress {
    for_each = var.port_sg
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      security_groups = ingress.value
      protocol    = "tcp"
    }
  }
  dynamic ingress {
    for_each = var.port_cidr
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      cidr_blocks = ingress.value
      protocol    = "tcp"
    }
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
    
  } 
  egress {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "-1"
  }
}
