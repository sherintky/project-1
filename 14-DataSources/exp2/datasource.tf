provider "aws" {
  region     = var.region
  version    = ">3.7"
}

provider "aws" {
  region     = "us-west-1"
  version    = ">3.7"
  alias      = "us-west-1"
}

/*
variable "zones_east" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "zones_west" {
  default = ["us-west-1a", "us-west-1c"]
}
*/

data "aws_availability_zones" "zones_east" {}
data "aws_availability_zones" "zones_west" {
  provider = aws.us-west-1
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



resource "aws_key_pair" "loginkey" {
   key_name = "terraform-demo-login-key"
   public_key = file("${path.module}/id_rsa.pub") 
}

resource "aws_instance" "dev-app" {
  ami           = lookup(var.ami,var.region)
  instance_type = "t2.micro"
  count             = 2
  key_name    = aws_key_pair.loginkey.key_name
  tags = {
    Name = element(var.tags,count.index)
  }

}


resource "aws_instance" "east_frontend" {
  ami           = "ami-0dba2cb6798deb6d8"
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zones.zones_east.names[count.index]
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
  availability_zone = data.aws_availability_zones.zones_west.names[count.index]
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
  availability_zone = data.aws_availability_zones.zones_east.names[count.index]
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
  availability_zone = data.aws_availability_zones.zones_west.names[count.index]
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

output "timestamp" { 
  value = local.time
}
