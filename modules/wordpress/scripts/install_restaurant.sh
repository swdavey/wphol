#!/bin/bash

MDS_ADMIN_USER=${mds_admin_user}
MDS_ADMIN_PASSWORD=${mds_admin_password}
MDS_PRIVATE_IP=${mds_ip}

WP_DB_USER=${wp_db_user}
WP_DB_PASSWORD=${wp_db_password}
WP_SCHEMA_NAME=${wp_schema_name}

WP_ADMIN_EMAIL=${wp_admin_email}
WP_ADMIN_PASSWORD=${wp_admin_password}
WP_ADMIN_USER=${wp_admin_user}

cd /home/opc

# Let the system settle down - wait a minute
sleep 60

# Read in the public IP address of the Wordpress server
WP_PUBLIC_IP=`cat /home/opc/public_ip.txt`

echo "Debug - print vars" > install.log

echo "MDS_ADMIN_USER: $MDS_ADMIN_USER" >> install.log
echo "MDS_ADMIN_PASSWORD: $MDS_ADMIN_PASSWORD" >> install.log
echo "MDS_PRIVATE_IP: $MDS_PRIVATE_IP" >> install.log

echo "WP_DB_USER: $WP_DB_USER" >> install.log
echo "WP_DB_PASSWORD: $WP_DB_PASSWORD" >> install.log
echo "WP_SCHEMA_NAME: $WP_SCHEMA_NAME" >> install.log

echo "WP_ADMIN_USER: $WP_ADMIN_USER" >> install.log
echo "WP_ADMIN_PASSWORD: $WP_ADMIN_PASSWORD" >> install.log
echo "WP_ADMIN_EMAIL: $WP_ADMIN_EMAIL" >> install.log

echo "WP_PUBLIC_IP: $WP_PUBLIC_IP" >> install.log

ls -l wp.sql >> install.log
ls -l /home/opc/public_ip.txt >> install.log

echo "End var debug" >> install.log

# Install worddpress CLI
echo "Installing WP CLI..." >> install.log
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
ls -l /usr/local/bin/wp >> install.log
echo "Installed." >> install.log

# Configure install to use database and app server
echo "Configuring wordpress server..." >> install.log
cp /var/www/html/wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$WP_SCHEMA_NAME/" wp-config.php
sed -i "s/username_here/$WP_DB_USER/" wp-config.php
sed -i "s/password_here/$WP_DB_PASSWORD/" wp-config.php
sed -i "s/localhost/$MDS_PRIVATE_IP/" wp-config.php
cp wp-config.php /var/www/html
chown apache:apache /var/www/html/wp-config.php
ls -l /var/www/html/wp-config.php >> install.log
/usr/local/bin/wp core install --path=/var/www/html --url=http://$WP_PUBLIC_IP --title="My Restaurant" --admin_user=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL > /home/opc/wp-password.out
ls -l /home/opc/wp-password.out >> install.log
echo "Configured." >> install.log

# Clean up default install (comments, posts and pages)
echo "Clean up default wordpress install..." >> install.log
/usr/local/bin/wp comment delete $(/usr/local/bin/wp comment list --format=ids --path=/var/www/html) --path=/var/www/html --force
/usr/local/bin/wp post delete $(/usr/local/bin/wp post list --format=ids --path=/var/www/html) --path=/var/www/html --force
/usr/local/bin/wp post delete $(/usr/local/bin/wp post list --post_type='page' --format=ids --path=/var/www/html) --path=/var/www/html --force
echo "Cleanup complete." >> install.log

# Install the theme and plugin(s)
/usr/local/bin/wp theme install auberge --activate --path=/var/www/html
/usr/local/bin/wp plugin install restropress --activate --path=/var/www/html

# Correct the ownership of wordpress install from root to apache
chown -R apache:apache /var/www/html

# Edit the schema dump then restore to the database server
echo "Restoring restaurant database tables..." >> install.log
echo "Webserver stopped" >> install.log
sed -i "s/app-public-ip/$WP_PUBLIC_IP/g" wp.sql >> install.log
sed -i "s/wp-admin-user/$WP_ADMIN_USER/g" wp.sql >> install.log
sed -i "s/wp-admin-email/$WP_ADMIN_EMAIL/g" wp.sql >> install.log
echo "Dump edited." >> install.log
mysql -u$MDS_ADMIN_USER -p$MDS_ADMIN_PASSWORD -h$MDS_PRIVATE_IP < wp.sql
echo "Database restaurant tables restored" >> install.log

# Reset the wordpress admin password
/usr/local/bin/wp user update 1 --user_pass=$WP_ADMIN_PASSWORD --path=/var/www/html

exit 0
