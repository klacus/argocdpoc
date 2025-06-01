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

terraform -chdir="$TFROOT" destroy -auto-approve -var-file="$TFVARFILE" -lock=false -var=build_repository_uri="localdev"