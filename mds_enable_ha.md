# oci-wordpress-mds

## Introduction

## Improve the Business Continuity: enable the MySQL HeatWave Database Instance High Availability

<details>
<summary>Task 1 - Enable High Availability  </summary>

1. We continue to work in the OCI Dashboard

2. Navigate to MySQL HeatWave database instances

    [OCI Burger menu for MySQL HeatWave Database instances](./images/./OCI-burger_menu-databases-db_system.png)

3. Click now on your instance name "MySQLInstance" to see the details.

    ![OCI MySQL HeatWave Database Service instances list](./images/./OCI-mds-instances-list.png)

4. Please note that HA is not enabled. Click "enable"

    ![OCI MySQL HeatWave Database Service instance details](./images/./OCI-mds-instance_details.png)

4. Confirm the activation clicking on "Enable"

    ![OCI MySQL HeatWave Database Service instance enable HA confirmation](./images/./OCI-mds-enable_HA.png)

5. By default, standalone and High Availability instances have different configuration settings. Choose the configuration "MySQL.VM.Standard.E4.4.64GB.HA" and press "Enable"

    ![OCI MySQL HeatWave Database Service instance choose HA configuration](./images/./OCI-mds-enable_HA-Choose_configuration.png)

6. It requires some minutes to enable the HA, so wait until the end of the activity

    ![OCI MySQL HeatWave Database Service instance enabling HA wait message](./images/OCI-mds-enable_HA-wait.png)

7. While a change is in progress, you can navigate instance details, but you are not allowed to make changes.
    We can see it from the "UPDATING" (orange) status.

    ![OCI MySQL HeatWave Database Service instance enabling HA update status](./images/./OCI-mds-enable_HA-update_status.png)

</details>

<details>
<summary>Task 1 - Test High Availability  </summary>

1. Please check the MySQL HeatWave Database Service instance endpoint, and note that the Private IP address of your instance doesn't change enabling or disabling the High Availability

2. We can now simulate a failure, suing the "switchover" option.
    From the Instance details page, open the "More actions" menu and choose

    ![]()

3. The wizard ask you which FD (Fault Domain) or AD (Availability Domain) to use.
    Choose one different from the actual

    ![]()

4. Even if the instance is in "UPDATE" (orange) status, it's still online. The downtime is limited to the seconds required to complete the switchover. Wait that the instance return to "ACTIVE" (green) status

    ![]()

5. Return to your "My Restaurant" web site and navigate. YOu can see that the web site is still working perfectly

    ![]()

</details>

