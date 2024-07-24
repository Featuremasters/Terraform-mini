provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "MyEC2"{
    ami = var.ami
    instance_type =var.instance_type
    vpc_security_group_ids=[aws_security_group.Firewall.id,"sg-0a0a2114da90995b3"]
    count=var.counts
    tags = {
        Name =element(var.tags,count.index)
    }
}
