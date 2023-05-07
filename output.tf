output "wordpress_public_ip" {
  value = module.wordpress.public_ip
}

output "wordpress_db_user" {
  value = var.wp_db_user
}

output "wordpress_db_password" {
  value = var.wp_db_password
}

output "mds_instance_ip" {
  value =  module.mds-instance.private_ip
}

output "ssh_private_key" {
  value = local.private_key_to_show
  sensitive = true
}
