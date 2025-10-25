provider "aws" {
  region     = "ap-south-1"
}
resource "aws_instance" "myec2" {
    ami = "ami-00af95fa354fdb788"
    instance_type = "t3.micro"
}
