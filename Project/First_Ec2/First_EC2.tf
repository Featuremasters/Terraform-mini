provider "aws" {
  region     = "us-east-1"
}
 
resource "aws_instance" "MyEC2"{
    ami = "ami-00beae93a2d981137"
    instance_type = "t2.micro"
    tags = {
        Name = "MyEC2"
    }
}