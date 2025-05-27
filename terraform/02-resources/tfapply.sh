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
TFVARFILE="${BASEDIR}/../../deployment/environments/${LIFECYCLE}/${REGION}.tfvars"
echo "Terraform working directory: $TFROOT"
echo "Terraform variables file: $TFVARFILE"

terraform -chdir="$TFROOT" apply -auto-approve -var-file="$TFVARFILE" -lock=false -var=build_repository_uri="localdev"