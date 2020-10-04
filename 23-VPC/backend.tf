terraform { 
   backend "s3" {
    bucket = "terraform-demo-amitvashist"
    key    = "terraform01-AV/terraform.tfstate"
    region = "us-east-1"
  }
}
