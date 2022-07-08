# Module ec2_instance

## Overview

Creates one or more ec2 instances with all the required mandatory tags.

terraform version >= 0.13



## Usage

### Single EC2 instance

```terraform
module "sysco_tags" {
  source = "git@github.aws.na.sysco.net:sysco-CET-terraform/modules//aws/sysco_tags"

  InfrastructureTeam = "CET"
  ApplicationID      = "APP-000009"
  Environment        = "NONPROD"
  ApplicationName    = "Test cloud ops"
  Owner              = "000-CloudServices@corp.sysco.com"
  PatchingOwner      = "2WMCS"
}

module "ec2-app" {
  source = "git@github.aws.na.sysco.net:sysco-CET-terraform/modules//aws/ec2_instance  

  instance_count         = 1
  name                   = "ec2-ubuntu-test"
  ami                    = "ami-ebd02392"
  instance_type          = "t3.small"
  subnet_id              = "subnet-0752685fb86e4aca9"
  vpc_security_group_ids = ["sg-0f5bdc84474de3db0"]
  key_name               = "test-keypair"
 
}

```

### multiple EC2 instances with additional EBS volumes

```terraform

module "ec2-app" {
  source = "git@github.aws.na.sysco.net:sysco-CET-terraform/modules//aws/ec2_instance  

  instance_count         = 2
  name                   = "ec2-ubuntu-test"
  ami                    = "ami-ebd02392"
  instance_type          = "t3.small"
  subnet_id              = "subnet-0752685fb86e4aca9"
  vpc_security_group_ids = ["sg-0f5bdc84474de3db0"]
  key_name               = "test-keypair"
   tags = merge(module.sysco_tags.tags,
    {
      "Approver"    = "000-CloudServices@corp.sysco.com"
    }
  )
  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 35
      encrypted   = true
      snapshot_id = "snap-0086c7626f9206850"
    }
  ]
}

```


## Notes

* network_interface can't be specified together with vpc_security_group_ids, associate_public_ip_address, subnet_id.
* Always use the gp3 disks instead of gp2.
* module does not support creating spot instances.