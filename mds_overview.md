# oci-wordpress-mds

## Introduction

## Check your MySQL HeatWave Database instance
<details>
<summary><h3> Task 1 - Explore MySQL HeatWave Database instance details </h3></summary>

1. Return to OCI Dashboard

2. Navigate to MySQL HeatWave database instances

    ![OCI Burger menu for MySQL HeatWave Database instances](./images/./OCI-burger_menu-databases-db_system.png)

3. On the left menu you can navigate through the various settings
    - **DB systems** contains the list of your MySQL HeatWave Database instances
    - **Backups** contains the backups of all the MySQL HeatWave Database instances
    - **Channels** contains the replica configurations
    - **Configurations** contains the configurations (aka my.cnf) of your MySQL HeatWave Database instances

4. Click now on your instance name "MySQLInstance" to see the details.

    ![OCI MySQL Database Service instances list](./images/./OCI-mds-instances-list.png)

5. In the Endpoints section there are the connection details. Please write down the private IP address (we use it later on)

    ![OCI MySQL Database Service instance details](./images/./OCI-mds-instance_details-private_ip.png)

5. As an alternative, you can also scroll down the page, and in the left menu choose "Endpoints" (scroll down the page).   
    You can see here the IP address of your instance and (optionally) the fqdn. We use this menu later to retrieve read replicas connection info. 

    ![OCI MySQL Database Service instance Endpoints](./images/./OCI-mds-instance_details-endpoints.png)

</details>