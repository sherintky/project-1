provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "frontend" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  depends_on    = [ aws_instance.backend ]

   lifecycle {
    create_before_destroy = true
  }
}



resource "aws_instance" "backend" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  count         = 2
  lifecycle {
    prevent_destroy = false
  }
  timeouts { 
    create = "60m"
    delete = "2h"
 }
}

