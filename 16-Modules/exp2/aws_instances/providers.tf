provider "aws" {
  region     = var.region
  version    = ">3.7"
}

provider "aws" {
  region     = "us-west-1"
  version    = ">3.7"
  alias      = "us-west-1"
}

