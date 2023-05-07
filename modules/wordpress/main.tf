## DATASOURCE
# Init Script Files

locals {
  php_script           = "~/install_php82.sh"
  wp_script            = "~/install_wp.sh"
  security_script      = "~/configure_local_security.sh"
  create_wp_db         = "~/create_wp_db.sh"
  restaurant_script    = "~/install_restaurant.sh"
  fault_domains_per_ad = 3
}

data "template_file" "install_php" {
  template = file("${path.module}/scripts/install_php82.sh")

  vars = {
    mysql_version         = var.mysql_version,
    user                  = var.vm_user
  }
}

data "template_file" "install_wp" {
  template = file("${path.module}/scripts/install_wp.sh")
}

data "template_file" "configure_local_security" {
  template = file("${path.module}/scripts/configure_local_security.sh")
}

data "template_file" "create_wp_db" {
  template = file("${path.module}/scripts/create_wp_db.sh")
  count    = var.nb_of_webserver
  vars = {
    mds_ip             = var.mds_ip
    mds_admin_password = var.mds_admin_password
    mds_admin_user     = var.mds_admin_user
    wp_db_password     = var.wp_db_password
    wp_db_user         = var.wp_db_user
    wp_schema_name     = var.wp_schema_name
    dedicated          = var.dedicated
    instancenb         = count.index+1
  }
}

data "template_file" "install_restaurant" {
  template = file("${path.module}/scripts/install_restaurant.sh")
  vars = {
    mds_ip             = var.mds_ip
    mds_admin_user     = var.mds_admin_user
    mds_admin_password = var.mds_admin_password
    wp_db_user         = var.wp_db_user
    wp_db_password     = var.wp_db_password
    wp_schema_name     = var.wp_schema_name
    wp_admin_user      = var.wp_admin_user
    wp_admin_password  = var.wp_admin_password
    wp_admin_email     = var.wp_admin_email
  }
}

resource "oci_core_instance" "WordPress" {
  count               = var.nb_of_webserver
  compartment_id      = var.compartment_ocid
  display_name        = "${var.label_prefix}${var.display_name}${count.index+1}"
  shape               = var.shape
  availability_domain = var.use_AD == false ? var.availability_domains[0] : var.availability_domains[count.index%length(var.availability_domains)]
  fault_domain        = var.use_AD == true ? "FAULT-DOMAIN-1" : "FAULT-DOMAIN-${(count.index  % local.fault_domains_per_ad) +1}"

  dynamic "shape_config" {
    for_each = local.is_flexible_node_shape ? [1] : []
    content {
      memory_in_gbs = var.flex_shape_memory
      ocpus = var.flex_shape_ocpus
    }
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "${var.label_prefix}${var.display_name}${count.index+1}"
    assign_public_ip = var.assign_public_ip
    hostname_label   = "${var.display_name}${count.index+1}"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
  }

  source_details {
    source_id   = var.image_id
    source_type = "image"
  }

  provisioner "file" {
    source      = "${path.module}/data/wp.sql"
    destination = "~/wp.sql"

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "file" {
    source      = "${path.module}/scripts/formatkey.html"
    destination = "~/formatkey.html"

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "file" {
    source      = "${path.module}/scripts/install_formatkey.sh"
    destination = "~/install_formatkey.sh"

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "file" {
    content     = data.template_file.install_php.rendered
    destination = local.php_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "file" {
    content     = data.template_file.install_wp.rendered
    destination = local.wp_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "file" {
    content     = data.template_file.configure_local_security.rendered
    destination = local.security_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "file" {
    content     = data.template_file.create_wp_db[count.index].rendered
    destination = local.create_wp_db

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "file" {
    content     = data.template_file.install_restaurant.rendered
    destination = local.restaurant_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "remote-exec" {
    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }

    inline = [
       "/bin/echo ${self.public_ip} > /home/opc/public_ip.txt",
       "chmod +x ${local.php_script}",
       "sudo ${local.php_script}",
       "chmod +x ${local.wp_script}",
       "sudo ${local.wp_script}",
       "chmod +x ${local.security_script}",
       "sudo ${local.security_script}",
       "chmod +x ${local.create_wp_db}",
       "sudo ${local.create_wp_db}",
       "chmod +x ${local.restaurant_script}",
       "sudo ${local.restaurant_script}",
       "chmod +x /home/opc/install_formatkey.sh",
       "sudo /home/opc/install_formatkey.sh"
            
    ]
  }

  timeouts {
    create = "10m"
  }
}
