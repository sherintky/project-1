variable "instance_type" {
  type = map

  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prd     = "t2.large"
  }
}

variable "key_name" {
   default = "terraform-demo"
}


variable "pvt_key" {
   default = "/root/.ssh/amitvashist-terraform.pem"
}


variable "sg_id" {
   default = "sg-00691bf04ae335d59"
}
