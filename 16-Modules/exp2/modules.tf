module "frontend" {
  source = "./aws_instances"
}


module "backend" {
  source = "./aws_instances"
  ec2_count = 2
}

output "frontend_ips" {
  value = module.frontend.ips
}


output "backend_ips" {
  value = module.backend.ips
}
