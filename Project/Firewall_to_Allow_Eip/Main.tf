provider "aws" {
  region     = "us-east-1"
}
resource "aws_eip" "lb" {
  domain   = "vpc"
}
resource "aws_security_group" "Firewall" {
  name        = "Terraform_Firewall"
}
resource "aws_vpc_security_group_ingress_rule" "Firewall_rule_in" {
  security_group_id = aws_security_group.Firewall.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "Firewall_rule_out" {
  security_group_id = aws_security_group.Firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
