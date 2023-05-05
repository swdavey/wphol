# oci-wordpress-mds

## Introduction
When your "Stack Job" is finished, it's change from "IN PROGRESS" (orange) state to "SUCCEEDED" state (green).
Now you can continue with next part.
We now see how to connect and test our wordpress website. 

In this lab we 
- retrieve the SSH to connect to our wordpress server
- retrieve public IP
- connect to our website
- login ad admin users

## Test Wordpress Installation

1. If you are logged out from OCI, re-login with your account.

2. Verify that the job is finished
    1. Open the burger menu

    ![OCI Burger menu](./images/./OCI-burger_menu-whereis.png)

    2. Select "Developer Services", then under "Resource Manager section" select "Jobs".  

    ![OCI Developer services inside Burger menu](./images/./OCI-burger_menu-developer_services-job.png)

    3. If your compartment is not selected, select it now

    4. Verify that the column "State" of your job is green/Succeeded, then click your job name to see the details page

    ![OCI jobs list](./images/./OCI-jobs-list.png)

3. Select "Job resources" from left side menu under "Resources". Here you can read all your resource settings (IP addresses, SSH keys, etc.) 

    ![OCI Job Resources](./images/./OCI-jobs-resources.png)

4. Let's retrieve the SSH key that we use later.
    Expand the "tls_private_key.public_private_key_pair" resource with the "Show" link

    ![OCI Job TLS keys information](./images/./OCI-jobs-resources-tls-expand.png)

5. Copy your private SSH key with the "copy" button. Becasue there are many keys, be sure to select **private_key_openssh**

    ![OCI SSH private keys retrieve](./images/./OCI-jobs-resources-tls-expand-ssh_key.png)

6. Paste the key in a text editor, change all the "\n" occurences with a line break, remove the initial and final **"**, then save the file as wordpress.key. If you are using a client with a proprietary key format (e.g. Putty) convert the key accordingly 

    ![TODO](./images/./todo.png)

7. Expand last line "WordPressServer1" to show the public IP.

8. If you click on the "WordPressServer1" name, you are automatically redirected to the compute instance and see the related configurations
