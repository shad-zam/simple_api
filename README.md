# simple_api

This repository has terraform configuration files & Ansible scripts to create a simple api on AWS. The ALB url will be desplayed after ansible playbooks which can be accessed publicily. 

Terraform will create all the required resources from a VPC to application Load balancer.

# Prerequisites

Terraform version 13 or higher should be installed on the running machine. Ansible also required to be installed on the machine. 

# Resources

* A VPC with the CIDR range with public & private subnets as provided.
* An MySQL RDS database.
* 3 ec2 instances
* An Application Loadbalancer
* Required IAM roles & IAM policies.
* Requred Security group rules

# Important Notice

I have setup an github runner to automate the planning outputs. As this is a learning project there will be no automated deployments with git hub runner. as I cant afford all the extra AWS charges.

# How to run the scripts on your account

* clone this repository
* Create a new key pair or copy your existing key pair file to 'Ansible' directory
* goto Terraform directory
* Update the configuration files as required ( vpc.tf , terraform.tf, app-svr.tf & alb.tf)
* update the inventory.tpl line 19 with the new keypair name.
* Run 'terraform init' to innitiate the terraform
* Run 'terraform plan -out=terraform.provisionplan' eg- $ terraform plan -out=terraform.provisionplan 
* Run 'terraform apply "terraform.provisionplan" ' This will create the exact same as the plan output which got desplayed.


