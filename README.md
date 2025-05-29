# argocdpoc
A proof of concept Argo CD deployment


### You need to create the following Azure resources manually:
Resource Group: terraformstates
Storage Account: lkohlterraformstates
Storage Account Container: terraform-state-files

# Installation

1. Clone the repository:

2. Update Subscription ID in Terraform backend and variable files:
    - Update the subscription_id in the file `/deployment/environments/poc/eus2-backend-entraid.conf`
    - Update the subscription_id in the file `/deployment/environments/poc/eus2-backend.conf`
    - Update the subscription_id in the file `/deployment/environments/poc/eus2.tfvars`

2. Create Entra ID users and groups\
    2.2. Deploy users and grouops. Run ``/terraform/01-entraid/tfapply-objects.sh`` then /``terraform/01-entraid/tfapply-membership.sh``

