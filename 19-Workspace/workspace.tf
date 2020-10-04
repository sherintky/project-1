provider "aws" {
  region = "us-east-1"
}

locals {
  default_name = "${join("-", list(terraform.workspace, "example"))}"
}

data "aws_ami" "myami" {
  most_recent = true
  owners  = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }

}



resource "aws_instance" "example2" {
  tags = {
    Name = local.default_name
  }

  ami           = data.aws_ami.myami.id
  instance_type = lookup(var.instance_type,terraform.workspace)
}

variable "instance_type" {
  type = map

  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prd     = "t2.large"
  }
}
