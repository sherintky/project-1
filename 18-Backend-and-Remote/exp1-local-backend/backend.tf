terraform { 
 backend "local" {
  path = "/var/tmp/terraform-local-backend/terraform.tfstate"
 }
}




provider "aws" {
  region     = var.region
  version    = ">3.7"
}

variable "region" {
  default = "us-east-1"
}

data "aws_ami" "myami" {
  most_recent = true
  owners  = ["amazon"]
  
  filter { 
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }

}



resource "aws_instance" "dev-app" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
  count             = 2
  tags = {
    Name = "dev-app-test-01"
  }

}

