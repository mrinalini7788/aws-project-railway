# 1. VPC Module
module "vpc" {
  source               = "./vpc"
  vpc_cidr             = "10.0.0.0/16"
  vpc_name             = "project-vpc"
  cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
  eu_availability_zone = ["us-east-1a", "us-east-1b"]
}

# 2. Security Group Module (THIS IS THE MISSING PIECE)
module "security_group" {
  source                   = "./security-groups"
  vpc_id                   = module.vpc.vpc_id
  ec2_sg_name              = "project-ec2-sg"
  public_subnet_cidr_block = ["10.0.1.0/24", "10.0.2.0/24"]
}

# 3. EC2 Module (Now it can find the security_group module)
module "ec2" {
  source             = "./ec2"
  ami_id             = "ami-04b4f1a9cf54c11d0"
  instance_type      = "t2.micro"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_group.sg_ec2_sg_ssh_http_id]
  key_name           = "project-keypair2025"
}
