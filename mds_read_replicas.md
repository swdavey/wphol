# oci-wordpress-mds

## Introduction

## Scale your service with Read Replicas
<details>
<summary><h3>Task 1 - Create Read Replicas</h3></summary>

1. Connect to OCI Dashboard

2. Navigate to MySQL HeatWave database instances

    [OCI Burger menu for MySQL HeatWave Database instances](./images/./OCI-burger_menu-databases-db_system.png)

3. Click now on your instance name "MySQLInstance" to see the details.

    ![OCI MySQL HeatWave Database Service instances list](./images/./OCI-mds-instances-list.png)

3. Scroll down the page to see the left side menu, then select "Read Replicas" and press button "Create read replica"

    ![OCI MySQL HeatWave Database Service instance read replicas](./images/./OCI-mds-read_replicas-empty.png)

4. Change the "Name" to "mysqlreadreplica1" and press "Create read replica"

    ![OCI MySQL HeatWave Database Service create read replica 1](./images/./OCI-mds-read_replicas-create1.png)

5. Click another time "Create replica" to create a second replica. Now use the name "mysqlreadreplica2" and confirm

    ![OCI MySQL HeatWave Database Service create read replica 2](./images/./OCI-mds-read_replicas-create2.png)

6. Replica creation requires some time, so continue with next task

    ![OCI MySQL HeatWave Database Service creating replicas](./images/./OCI-mds-read_replicas-creating_replicas.png)

</details>


<details>
<summary><h3>Task 2 - Install and configure ludicrousdb</h3></summary>

1. Connect with ssh to your wordpress server, as you did in lab 1

2. Execute these commands to install ludicrousdb

    ``` shell
    cd /var/www/html/wp-content/plugins
    sudo wget https://github.com/stuttter/ludicrousdb/archive/refs/heads/master.zip
    sudo unzip master.zip
    sudo mv ludicrousdb-master ludicrousdb
    sudo rm master.zip
    sudo chown -R apache. ludicrousdb
    sudo cp ludicrousdb/ludicrousdb/drop-ins/db.php ../db.php
    sudo cp ludicrousdb/ludicrousdb/drop-ins/db-config.php ../../
    ```

</details>

<details>
<summary><h3>Task 3 - Create a snippet</h3></summary>
</details>

<details>
<summary><h3>Task 4 - Test read replicas</h3></summary>
</details>
