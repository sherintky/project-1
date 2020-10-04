output "ips" {
  value = aws_instance.instance.*.public_ip
}

#output "PublicIP_East_Backend" {
#  value = aws_instance.east_backend.*.public_ip
#}

output "timestamp" {
  value = local.time
}

