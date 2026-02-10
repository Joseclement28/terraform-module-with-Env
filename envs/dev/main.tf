module "network" {
    source = "../../modules/network"
    vpc_cidr    = var.vpc_cidr
    vpc_name    = var.vpc_name
    subnet_cidr = var.subnet_cidr
}

module "security_group" {
    source          = "../../modules/security-group"
    vpc_id          = module.network.vpc_id
    allowed_ingress = var.allowed_ingress
    allowed_egress  = var.allowed_egress 
}

module "ec2" {
    source = "../../modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    subnet_id = module.network.subnet_id
    private_ip = var.private_ip
    key_name   = var.key_name
    security_group_id = module.security_group.security_group_id
    instance_name = var.instance_name
    ebs_size = var.ebs_size
}