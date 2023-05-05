# oci-wordpress-mds

## Introduction
On one hand, MySQL is the world’s most popular open-source database. On the other, WordPress is the leading content management system. This step by step workshop will combine both technologies and will show and guide participants on running WordPress with MySQL HeatWave.

In this hands-on workshop, you will learn:

More about MySQL HeatWave
- Enabling MySQL HeatWave on Oracle Cloud
- Deploying a new website with WordPress and MySQL
- Growing from a small development environment to a full production architecture
- Scale your environment for any future load
- Making your architecture highly available

An Oracle Cloud account is required and enough privileges to 
- execute stacks
- create and manage network configurations
- create and manage compute machines
- create and manage MySQL HeatWave Database Instances
We recommend to use an administrative account and a dedicated compartment.

If you do not have an Oracle Account, you can claim an Oracle Cloud Free Trial account with FREE 300 USD credits [here] (https://www.oracle.com/cloud/free/)

## Lab preparation
Deploy Wordpress on Oracle Cloud Intrastructure (OCI) and MySQL Database Service (MDS) using these Terraform modules.

The same modules are used as Resource Manager Stack.

The latest stack can be downloaded directly in the releases (the zip file)

Use button below to start the stack

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/swdavey/wphol/releases/download/v2.0/stack_wordpress_mds.zip)