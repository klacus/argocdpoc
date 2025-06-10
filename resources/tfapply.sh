#!/bin/bash

BASEDIR=$(dirname "$(realpath "$0")")

printusage() {
  echo "Usage: $0 <lifecycle> <region>"
}

LIFECYCLE=${1}
if [ -z "${LIFECYCLE}" ]; then
  printusage
  exit 1
fi

REGION=${2}
if [ -z "${REGION}" ]; then
  printusage
  exit 2
fi

TFROOT="${BASEDIR}"
TFVARFILE="${BASEDIR}/../deployment/environments/${LIFECYCLE}/${REGION}.tfvars"
echo "Terraform working directory: $TFROOT"
echo "Terraform variables file: $TFVARFILE"

terraform -chdir="$TFROOT" apply -auto-approve -var-file="$TFVARFILE" -lock=false -var=build_repository_uri="localdev"
if [ $? -ne 0 ]; then
  echo "Terraform apply failed."
  exit 3
fi

# Exporting kubeconfig from Azure Key Vault to a local file, then converting it for kubelogin
export KUBECONFIG="${HOME}/.kube/argocdpoc"
echo "Exporting kubeconfig from Key Vault ..."
if [ -f "${KUBECONFIG}" ]; then
  echo "Kubeconfig file already exists, removing it before downloading a new one."
  rm -f "${KUBECONFIG}"
fi
az keyvault secret download --vault-name "argocdpoc-eus2-poc" --name "aks-kube-config" --file "${KUBECONFIG}"
if [ $? -ne 0 ]; then
  echo "Failed to download kubeconfig from Key Vault."
  exit 4
fi
echo "Kubeconfig file downloaded successfully to ${KUBECONFIG}."

echo "Converting kubeconfig for kubelogin ..."
kubelogin convert-kubeconfig --kubeconfig "${KUBECONFIG}" --login azurecli
if [ $? -ne 0 ]; then
  echo "Failed to convert kubeconfig for kubelogin."
  exit 5
fi
echo "Removing old kubelogin tokens ..."
kubelogin remove-tokens
echo "Kubeconfig exported and converted successfully."