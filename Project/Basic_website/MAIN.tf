provider "aws" {
  region = "us-west-1"
}
data "aws_ami" "imageami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
resource "aws_instance" "MyEC2" {
  ami                    = data.aws_ami.imageami.image_id
  instance_type          = "t2.micro"
  key_name               = "terraform"
  vpc_security_group_ids = [aws_security_group.Terraform_Firewall.id]
  tags = {
    Name = "MyEC2"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./terraform.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = ["sudo yum -y install nginx", "sudo systemctl start nginx"]
  }
  provisioner "local-exec" {
    command = "echo Website is created and private id is${self.private_ip}>> summary.txt"
  }
}
variable "sg_port" {
  default = [80, 22]
}
resource "aws_security_group" "Terraform_Firewall" {
  name = "Firewall"
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
  security_group_id = aws_security_group.Terraform_Firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
