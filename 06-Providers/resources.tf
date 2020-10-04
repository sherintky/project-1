provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
  version    = ">3.7"
}


#provider "wavefront" {
#   address = "cluster.wavefront.com"
#   version    = "2.2"
#}


provider "aws" {
  region     = "us-west-1"
  access_key = ""
  secret_key = ""
  version    = ">3.7"
  alias      = "us-west-1"

}

resource "aws_instance" "frontend" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
}



resource "aws_instance" "frontend_west" {
  ami           = "ami-0e4035ae3f70c400f"
  instance_type = "t2.micro"
  provider      = aws.us-west-1
}

