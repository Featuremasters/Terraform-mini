provider "aws" {
  region     = "us-west-1"
}
data "aws_ami" "imageami"{
    most_recent =   true
    owners = ["amazon"]
    filter {
      name= "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}
resource "aws_instance" "MyEC2"{
    ami = data.aws_ami.imageami.image_id
    instance_type = "t2.micro"
    tags = {
        Name = "MyEC2"
    }
}