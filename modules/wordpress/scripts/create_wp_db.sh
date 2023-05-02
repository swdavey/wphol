#!/bin/bash

DEDICATED=${dedicated}
INSTANCE=${instancenb}

if [ "$DEDICATED" == "true" ]
then
   wpschema="${wp_schema_name}$INSTANCE"
   wpname="${wp_db_user}$INSTANCE"
else
   wpschema="${wp_schema_name}"
   wpname="${wp_db_user}"
fi


mysqlsh --user ${mds_admin_user} --password=${mds_admin_password} --host ${mds_ip} --sql -e "CREATE DATABASE $wpschema;"
mysqlsh --user ${mds_admin_user} --password=${mds_admin_password} --host ${mds_ip} --sql -e "CREATE USER $wpname identified by '${wp_db_password}';"
mysqlsh --user ${mds_admin_user} --password=${mds_admin_password} --host ${mds_ip} --sql -e "GRANT ALL PRIVILEGES ON $wpschema.* TO $wpname;"

echo "WordPress Database and User created !"
echo "WP USER = $wpname"
echo "WP SCHEMA = $wpschema"
