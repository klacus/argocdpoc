#!/bin/bash

source ../configuration.sh

echo "Deploying Traefik ..."
helm pull https://helm.traefik.io/traefik --version 17.3.2 --untar

helm upgrade traefik ./traefik --install --namespace traefik --create-namespace -f ./values-custom.yaml
