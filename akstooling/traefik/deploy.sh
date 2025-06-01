#!/bin/bash

source ../../configuration.sh

VERSION=35.4.0

echo "Deploying Traefik ..."
helm pull oci://ghcr.io/traefik/helm/traefik --version ${VERSION}

kubectl apply -f prerequisites.yaml -n traefik --wait

# helm upgrade traefik ./traefik --install --namespace traefik --create-namespace -f ./values-custom.yaml
helm upgrade traefik oci://ghcr.io/traefik/helm/traefik --install --version ${VERSION} --namespace traefik --create-namespace -f ./values-custom.yaml
