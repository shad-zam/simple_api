module "bastian_sg" {
  source      = "./terraform_modules/aws-sg"
  name        = "bastian-sg"
  description = "bastian host sg"
  vpc_id      = module.vpc.vpc_id
  port_cidr = {
    "22" = ["0.0.0.0/0"]
  }

  tags = {
    Owner       = "Arshad"
    Environment = "non-prod"
  }

}

data "aws_ami" "bastian_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2022-ami-*-5.15-x86_64"]
  }

}


module "bastian" {
  source = "./terraform_modules/ec2-instance"

  instance_count              = 1
  name                        = "bastian"
  ami                         = data.aws_ami.bastian_ami.id
  instance_type               = "t3.micro"
  subnet                      = element(module.vpc.public_subnets, 1)
  vpc_security_group_ids      = [module.bastian_sg.id]
  key_name                    = "eu-west2"
  associate_public_ip_address = true


  root_block_device = [
    {
      volume_type = "gp3"
      encrypted   = true
      volume_size = 8
    },
  ]


}

output "bastian_public_ip" {
  value = module.bastian.public_ip
}