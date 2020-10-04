resource "aws_instance" "web" {
  ami               = "ami-0947d2ba12ee1ff75"
  availability_zone = "us-east-1a"
  instance_type     = "t2.micro"

  tags = {
    Name = "Hello-EBS"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 40

  tags = {
    Name = "Hello-EBS-Volume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id
}
