output "vpc_id" {
  value = module.network.vpc_id
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "instance_id" {
  value = module.ec2.instance_id
}
