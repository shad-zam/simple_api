data "template_file" "inventory" {
  template = file("inventory.tpl")

  vars = {
    ec2_instance_private_ip    = module.ec2-app.private_ip[0]
    ec2_instance_private_ip2   = module.ec2-app.private_ip[1]
    bastian_instance_public_ip = module.bastian.public_ip[0]
    rds_instance_name          = module.mysql.db_instance_name[0]
    rds_instance_username      = module.mysql.db_instance_username[0]
    rds_instance_port          = module.mysql.db_instance_port[0]
    rds_instance_endpoint      = module.mysql.db_instance_address[0]
    rds_instance_id            = module.mysql.db_instance_id[0]
    alb_dns                    = module.alb.alb_dns_name
  }
}

resource "local_file" "inventory" {
  content  = data.template_file.inventory.rendered
  filename = pathexpand("../Ansible/inventory")
}
