data "aws_ami" "ec2_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
    # values = ["CIS Amazon Linux 2 Kernel 5.10 Benchmark v1*"]
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

}

module "app_svr_sg" {
  source      = "./terraform_modules/aws-sg"
  name        = "app-server-sg"
  description = "application server sg"
  vpc_id      = module.vpc.vpc_id
  port_sg = {
    "80"  = [module.alb_sg.id]
    "443" = [module.alb_sg.id]
    "22"  = [module.bastian_sg.id]
  }
  tags = {
    Owner       = "Arshad"
    Environment = "non-prod"
  }
}

resource "random_integer" "subnet" {
  min = 1
  max = 3
  keepers = {
    # Generate a new integer each time the ami is changed
    ami_id = data.aws_ami.ec2_ami.id
  }
}


module "ec2-app" {
  source = "./terraform_modules/ec2-instance"

  instance_count         = 2
  name                   = "app-server"
  ami                    = data.aws_ami.ec2_ami.id
  instance_type          = "t2.micro"
  subnet                 = element(module.vpc.private_subnets, random_integer.subnet.result)
  vpc_security_group_ids = [module.app_svr_sg.id]
  key_name               = "eu-west2"
  iam_instance_profile   = module.app_svr_role.name


  root_block_device = [
    {
      volume_type = "gp3"
      encrypted   = true
      volume_size = 8
    },
  ]
  tags = {
    Owner       = "Arshad"
    Environment = "non-prod"
    Inspector   = "common"
  }


}

module "app_svr_role" {
  source = "./terraform_modules/aws-iam_profile"

  name     = "app_svr_role"
  policies = ["AmazonSSMManagedInstanceCore"]

}


output "ec2_private_ip" {
  value = module.ec2-app.private_ip
}