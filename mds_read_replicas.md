# oci-wordpress-mds

## Introduction

## Scale your service with Read Replicas
<details>
<summary><h3>Task 1 - Create Read Replicas</h3></summary>

1. Connect to OCI Dashboard

2. Navigate to MySQL HeatWave database instances page

    ![OCI Burger menu for MySQL HeatWave Database instances](./images/./OCI-burger_menu-databases-db_system.png)

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
<summary><h3>Task 2 - Install and configure ludicrousdb wordpress plugin</h3></summary>

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

4. Retrieve MySQL load balancer Endpoint for read replicas.  
    Return to OCI Dashboard and go to MySQL HeatWave database instances

    ![OCI Burger menu for MySQL HeatWave Database instances](./images/./OCI-burger_menu-databases-db_system.png)

5. Click now on your instance name "MySQLInstance" to see the details.

    ![OCI MySQL HeatWave Database Service instances list](./images/./OCI-mds-instances-list.png)
    
6. Scroll down the page, and in the left menu choose "Endpoints".   
    You can see here the IP address of your instance for read write access **DB system primary** and for the read replicas load balancer **Read replica load balancer**. Write down thewe two IP, needed for the next step

    ![OCI MySQL Database Service instance Endpoints](./images/./OCI-mds-read_replicas-endpoints.png)

7. We just need now to configure LudicrousDB to use the Read Replica Load Balancer. With and editor (like vim or nano) edit the db-config.php configuration file

    ``` shell
    cd /var/www/html/
    sudo vim db-config.php 

    ```

8. Scroll down the file to the database configuration section **$wpdb->add_database( array(** like in the example below

    ![Ludicrousdb database configuration file](./images/./ludicrousdb-db_configuration_empty.png)

9. Edit the lines like in the below example, using your IP addresses retrieved in previous steps  

    ![Ludicrousdb database configuration file](./images/./ludicrousdb-db_configuration_sample.png)

10. Save your canghes and aeturn to My Restaurant web page and check that the web site is still working and there are no issues with the new plugin

</details>

<details>
<summary><h3>Task 3 - Create a snippet</h3></summary>

1. Login to Wordpress as admin using the wp-admin page and entering the requested credentials (specified during the job creation in lab preparation lab) 

    http://***public-ip-address***/wp-admin

    ![Wordpress login](./images/WP_wp_admin.png)

2. In the wordpress management page choose "Plugins" in the left side menu, then click the button "Add New"

    ![Wordpress plugins menu](./images/WP-plugins_menu.png)

3. In the left side textbox "Keyword" write "snippets" as in teh picture below

    ![Wordpress snippets plugin search](./images/WP-plugins-snippets_search.png)

4. Choose "WPCode" plugin and press "Install now"

    ![Wordpress WPCode isntallation](./images/WP-plugins-snippets-wpcode-install.png)

5. From left side menu choose Installed plugins, then press "Activate"under "WPCode Lite"

    ![Wordpress WPCcode plugin activation](./images/WP-plugins-snippets-wpcode-activate.png)

6. A new menu option is now visible in the left side menu.  
    Click on "Code snippets"

    ![Wordpress WPCOde snippet menu](./images/WP-plugins-wpcode_menu.png)

7. Choose "+ Add snippet" and select "Add Your Custom Code (New Snippet)". When teh mouse is over the option, a new button is displayed "USe snippet". Click it

    ![Wordpress WPCode add new snippet](./images/WP-plugins-wpcode-add_new.png)

8. Now insert snippet settings
    1. Add a title to our snippet: "read replicas check"
    2. Select "Code Type": PHP
    3. insert this code in "Code Preview"
        ``` php
        <?php
        global $wpdb;
        $result = $wpdb->get_results("select @@hostname as host");
        echo "<strong>host:</strong> " . $result[0]->host;
        ?>
        ```
    4. Scroll down to "insertion" and click "Run Everywhere" in "Location" to expand the section
    5. Select "Page-Specific"
    6. Click on "INsert Before Paragraph"

    ![Wordpress snippet settings](./images/WP-plugins-wpcode-snippet_conf1.png)

9. Keep the default insert before paragraph 1 and in the top of the page 
    1. Click Inactive switch to activate
    2. Click "Update" to save your changes

    ![Wordpress snippet save](./images/WP-plugins-wpcode-snippet_conf2.png)

</details>

<details>
<summary><h3>Task 4 - Test read replicas</h3></summary>

1. We can now test our read replicas.  
    Click My Restaurant to return to our web site content

    ![Return to My Restaurant web site](./images/WP-visit_website.png)

2. Select "Sample page".  
    You will see a new line under the titkle and before the text "host: *XXX*".  
    Refresh the page multiple times to see that the host changes periodically

    ![Sample page](./images/WP-sample_page.png)

3. This end our workshop.  
    Please remember that tenancy costs are calcualted on running instances and space used.
    Shutdown the instances when you don't need them or use the stack to easily destroy what we did in this workshop. 

</details>

