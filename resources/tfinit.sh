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
TFBACKEND="${BASEDIR}/../deployment/environments/${LIFECYCLE}/${REGION}-backend.conf"

echo "Initializing Terraform in ${TFROOT} directory ..."
terraform -chdir="${TFROOT}" init -reconfigure -backend-config=${TFBACKEND}