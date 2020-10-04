provider "aws" {
  region     = "us-east-1"
  version    = ">3.7"
}

provider "aws" {
  region     = "us-west-1"
  version    = ">3.7"
  alias      = "us-west-1"
}

variable "zones_east" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "zones_west" {
  default = ["us-west-1a", "us-west-1c"]
}


variable "multi-region-deployment" {
  default = true
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



resource "aws_instance" "east_frontend" {
  ami           = "ami-0dba2cb6798deb6d8"
  instance_type = "t2.micro"
  availability_zone = var.zones_east[count.index]
  count             = 2
  depends_on    = [ aws_instance.east_backend ]
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = local.default_frontend_name 
  }

}


resource "aws_instance" "west_frontend" {
  ami           = "ami-0e4035ae3f70c400f"
  instance_type = "t2.micro"
  availability_zone = var.zones_west[count.index]
  count             = var.multi-region-deployment ? 2 : 0 
  depends_on    = [ aws_instance.west_backend ]
  provider      = aws.us-west-1

  lifecycle {
    create_before_destroy = true
  }

#  tags = {
#    Name = local.westfrontend_name 
#  }
  
  tags = local.some_tags


}


resource "aws_instance" "east_backend" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  availability_zone = var.zones_east[count.index]
  count             = 2
  lifecycle {
    prevent_destroy = false
  }
 
  tags = {
    Name = local.westfrontend_name 
  }

}


resource "aws_instance" "west_backend" {
  ami           = "ami-0e4035ae3f70c400f"
  instance_type = "t2.micro"
  availability_zone = var.zones_west[count.index]
  count             = var.multi-region-deployment ? 2 : 0
  provider      = aws.us-west-1
  lifecycle {
    prevent_destroy = false
  }
  
  tags = {
    Name = local.westbackend_name 
  }

}

output "PublicIP_East_Frontend" {
  value = aws_instance.east_frontend.*.public_ip
}

output "PublicIP_East_Backend" {
  value = aws_instance.east_backend.*.public_ip
}
