provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "myec2" {
    ami = "ami-00c39f71452c0877"
    instance_type = "t2.micro"
}
