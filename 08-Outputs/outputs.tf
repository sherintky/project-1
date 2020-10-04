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
}


resource "aws_instance" "backend" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  availability_zone = var.zones[count.index]
  count             = 2
}



output "backend_public_ip" {
  value = aws_instance.backend.*.public_ip
}

output "backend_ips" {
  value = "${list(aws_instance.backend.*.public_ip  , aws_instance.backend.*.public_dns)}"
}

output "public_ip" {
  value = aws_instance.example.public_ip
}


output "public_dns" {
  value = aws_instance.example.public_dns
}

resource "aws_eip" "lb" {
  vpc   = true
}

output "eip" {
  value = aws_eip.lb
}
