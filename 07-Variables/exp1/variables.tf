provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
  version    = ">3.7"
}


variable "zones" {
  default = ["us-east-1a", "us-east-1b"]
}


resource "aws_instance" "example" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  availability_zone = var.zones[count.index]
  count             = 2
}

