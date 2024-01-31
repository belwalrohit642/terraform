cidr_block = "10.0.0.0/16"
env_prefix = "dev"
avail_zone =  ["us-east-1a", "us-east-1b"]
private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]

public_keylocation = "/home/ohb/.ssh/id_rsa.pub"
ami_id = "ami-0c7217cdde317cfec"
total_count = 1
instance_type = "t2.micro"
