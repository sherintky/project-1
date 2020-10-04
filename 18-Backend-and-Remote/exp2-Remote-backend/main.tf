resource "aws_instance" "dev-app" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
  count             = 2
  tags = {
    Name = "dev-app-test-01"
  }

}

