module "ec2_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-cluster"
  instance_count         = 2

  ami                    = "ami-0947d2ba12ee1ff75"
  instance_type          = "t2.micro"
  key_name               = "mykey-tf"
  monitoring             = true
  vpc_security_group_ids = ["sg-00691bf04ae335d59"]
  subnet_id              = "subnet-04fb5262"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
