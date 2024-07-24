variable "vpn-ip" {
    default= "101.0.62.210/32"
}
variable "app-port" {
    default= "8080"
}
variable "shh" {
    default="22"
}
variable "ftp_port" {
    default="21"
}
variable "ami" {
    default="ami-00beae93a2d981137"
}
variable "instance_type" {
    default="t2.micro"
}
variable "counts" {
    default=3
}
variable "tags" {
    default=["EC1","Ec2","EC3"]
}