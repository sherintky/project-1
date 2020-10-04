data "aws_availability_zones" "zones_east" {}
data "aws_availability_zones" "zones_west" {
  provider = aws.us-west-1
}

variable "multi-region-deployment" {
  default = "true"
}

variable "ec2_count" {
  default = 1
}


variable "env-name" {
  default = "Terraform-East"
}


variable "env-name-2" {
  default = "Prod-AV"
}

locals {
  some_tags = {
    Owner = "DevOps Team"
    Project = "Initial Demo"
    Service = "Backend"
    Name    = local.westfrontend_name
 }
}

locals {
  default_frontend_name = "${join("-", list(var.env-name, "Frontend"))}"
  defualt_backend_name  =  "${join("-", list(var.env-name, "Backend"))}"
  westfrontend_name = "${join("-", list(var.env-name-2, "Frontend"))}"
  westbackend_name  =  "${join("-", list(var.env-name-2, "Backend"))}"
}

locals {
 time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region" {
  default = "us-east-1"
}


variable "ami" {
  type = map
  default = {
    "us-east-1" = "ami-0947d2ba12ee1ff75"
    "us-west-1" = "ami-0e4035ae3f70c400f"
    "ap-south-1" = "ami-0e306788ff2473ccb"

  }
}

variable "tags" {
  type = list
  default = ["app-dev-first", "app-dev-second"]
}


