variable "sg_port" {
  default = [8080, 22, 21]
}

resource "aws_security_group" "Firewall" {
  name = "Terraform_Firewall"


  dynamic "ingress" {
    for_each = var.sg_port
    iterator = port
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = port.value
      protocol    = "tcp"
      to_port     = port.value
    }
  }
}
resource "aws_vpc_security_group_egress_rule" "Firewall_rule_out" {
  security_group_id = aws_security_group.Firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}