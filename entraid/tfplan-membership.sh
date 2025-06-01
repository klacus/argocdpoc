#!/bin/bash

BASEDIR=$(dirname "$(realpath "$0")")


LIFECYCLE=${1}
if [ -z "${LIFECYCLE}" ]; then
  echo "Usage: $0 <lifecycle>"
  exit 1
fi

REGION=${2}
if [ -z "${REGION}" ]; then
  echo "Usage: $0 <lifecycle> <region>"
  exit 2
fi

TFROOT="${BASEDIR}"
TFVARFILE="${BASEDIR}/../deployment/environments/${LIFECYCLE}/${REGION}.tfvars"

echo "Terraform working directory: $TFROOT"
echo "Terraform variables file: $TFVARFILE"

# See plan for users and groups
terraform plan -var-file="$TFVARFILE" -lock=false -var=build_repository_uri="localdev" -var=build_repository_uri="localdev" -target=azuread_group_member.engineering -target=azuread_group_member.engineering_managers -target=azuread_group_member.system1 -target=azuread_group_member.system1_managers -target=azuread_group_member.system2 -target=azuread_group_member.system2_managers
