resource "aws_security_group" "Firewall" {
  name        = "Terraform_Firewall"
}
resource "aws_vpc_security_group_ingress_rule" "app_port" {
  security_group_id = aws_security_group.Firewall.id
  cidr_ipv4         = var.vpn-ip
  from_port         = var.app-port
  ip_protocol       = "tcp"
  to_port           = var.app-port
}
resource "aws_vpc_security_group_ingress_rule" "shh" {
  security_group_id = aws_security_group.Firewall.id
  cidr_ipv4         = var.vpn-ip
  from_port         = var.shh
  ip_protocol       = "tcp"
  to_port           = var.shh
}
resource "aws_vpc_security_group_ingress_rule" "ftp_port" {
  security_group_id = aws_security_group.Firewall.id
  cidr_ipv4         = var.vpn-ip
  from_port         = var.ftp_port
  ip_protocol       = "tcp"
  to_port           = var.ftp_port
}

