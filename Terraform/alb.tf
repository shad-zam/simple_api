

module "alb_sg" {
  source      = "./terraform_modules/aws-sg"
  name        = "ALB-sg"
  description = "Load Balancer sg"
  vpc_id      = module.vpc.vpc_id
  port_cidr = {
    "80"  = ["0.0.0.0/0"]
    "443" = ["0.0.0.0/0"]
  }

  tags = {
    Owner       = "Arshad"
    Environment = "non-prod"
  }

}

module "alb" {
  source             = "./terraform_modules/aws-alb"
  name               = "swiscom-app-lb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [module.alb_sg.id]
  attach_target      = true
  target_instances   = module.ec2-app.id
  instance_count     = var.instance_count
}

output "loadbalancer_dns" {
  value = module.alb.alb_dns_name
}

