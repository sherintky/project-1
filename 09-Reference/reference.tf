provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
  version    = ">3.7"
}

resource "aws_instance" "example" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
  vpc   = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.example.id
  allocation_id = aws_eip.lb.id
}


output "eip" {
  value = aws_eip.lb
}

output "public_ip" {
  value = aws_instance.example.public_ip
}

