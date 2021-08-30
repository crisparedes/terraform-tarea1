module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "cparedes-vpc"
  cidr = "33.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  private_subnets = ["33.0.1.0/24", "33.0.2.0/24", "33.0.3.0/24"]
  public_subnets  = ["33.0.101.0/24", "33.0.102.0/24", "33.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-083ac7c7ecf9bb9b0" # us-west-2
  instance_type = "t3.micro"

  tags = {
    Name = "cparedes-tf-task2"
  }
  
  subnet_id = module.vpc.private_subnets[0]
}
