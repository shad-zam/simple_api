[app_hosts]
${ec2_instance_private_ip}    ansible_connection=ssh        ansible_user=ec2-user
${ec2_instance_private_ip2}   ansible_connection=ssh        ansible_user=ec2-user


[bastian_host]
${bastian_instance_public_ip}  ansible_connection=ssh        ansible_user=ec2-user

[localhost]
localhost ansible_connection=local

[app_hosts:vars]
db_instance_name = ${rds_instance_name}
db_instance_username = ${rds_instance_username}
db_instance_port = ${rds_instance_port}
db_instance_endpoint = ${rds_instance_endpoint}
rds_instance_id = ${rds_instance_id}
api_url = http://${alb_dns}/api/
ansible_ssh_common_args='-oProxyCommand="ssh -i eu-west2.pem -W %h:%p -o StrictHostKeyChecking=no ec2-user@${bastian_instance_public_ip}" '
ansible_host_key_checking = False

[all:vars]
ansible_host_key_checking = false