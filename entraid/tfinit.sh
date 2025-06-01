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
TFBACKEND="${BASEDIR}/../deployment/environments/${LIFECYCLE}/${REGION}-backend-entraid.conf"

echo "Initializing Terraform in ${TFROOT} directory ..."
terraform init -reconfigure -backend-config=${TFBACKEND}