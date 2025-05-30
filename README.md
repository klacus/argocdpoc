# argocdpoc
A proof of concept Argo CD deployment.

The goal of this repository to deploy a working Argo CD solution using Azure Kubernetes Services (AKS) from scratch to provide a basic sample environment to demonstrate Argo CD and how it can enable developers to deploy automatically deploy and manage their workload on Kubernetes using Argo CD.


# Do not forget removing Azure resources when you done with the POC to avoid unnecessary charges and costs!

# Prerequisites

Linux and bash shell.
azure cli
kubectl
kubelogin through azure cli `sudo az aks install-cli` https://azure.github.io/kubelogin/install.html#using-azure-cli

## Recommended
k9s

### You need to create the following Azure resources manually:
Resource Group: terraformstates
Storage Account: lkohlterraformstates
Storage Account Container: terraform-state-files

# Installation

1. Clone the repository:

2. Update Subscription ID in Terraform backend and variable files:
    - Update the subscription_id and the azure_tenant_id in the file `/deployment/environments/poc/eus2-backend-entraid.conf`
    - Update the subscription_id and the azure_tenant_id in the file `/deployment/environments/poc/eus2-backend.conf`
    - Update the subscription_id and the azure_tenant_id in the file `/deployment/environments/poc/eus2.tfvars`

2. Create Entra ID users and groups\
    2.2. Deploy users and grouops. Run ``/terraform/01-entraid/tfapply-objects.sh`` then /``terraform/01-entraid/tfapply-membership.sh``

3. Deploy AKS
tfapply. Run `/terraform/02-aks/tfapply.sh`

4. Deploy Tooling
- cert-manager
- traefik
- registry
- argocd

