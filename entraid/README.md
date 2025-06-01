# Terraform is not for AD / EntraId

Terraform is not the best managing AD / EntraId. Use it only when minimal resources needed that likely do not change often.


# Install instruction
1. run the `./tfinit.sh poc eus2` command to initialize the Terraform environment.
2. run the `./tfapply-objects.sh poc eus2` command to apply the Terraform configuration and create the group and user resources
3. run the `./tfapply-membership.sh poc eus2` command to apply the Terraform configuration and add the users to the groups

# Notes
Using the membership Terraform plan script will fail if the apply objects script has not been run first, as the groups and users will not exist yet. The membership script is designed to be run after the objects have been created. Terraform can not have the groups and users created in the same execution as it can not properly order / wait until dependent resources created.
