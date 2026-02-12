aws_region      = "ap-south-1"
vpc_cidr        = "192.168.0.0/16"
vpc_name        = "dev-vpc"
subnet_cidr     = "192.168.10.0/24"
ami_id          = "ami-0f5ee92e2d63afc18"
instance_type   = "t2.micro"
private_ip      = "192.168.10.100"
key_name        = "production"
instance_name   = "dev-web"
ebs_size        = "10"

allowed_ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    },

    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  
    },

    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    },

    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    },

    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    },

    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    }

]

allowed_egress = [
    {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
]


