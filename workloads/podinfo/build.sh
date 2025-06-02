#!/bin/bash

VERSIONTAG=1.0.0

docker build -t podinfo:${VERSIONTAG} .

# docker login ${ACR}.azurecr.io
az acr login --name ${ACR}

docker tag podinfo:${VERSIONTAG} ${ACR}.azurecr.io/podinfo:${VERSIONTAG}

docker images | grep podinfo

docker push ${ACR}.azurecr.io/podinfo:${VERSIONTAG}

# curl -L https://${ACR}.azurecr.io/v2/_catalog
# curl -L https://${ACR}.azurecr.io/v2/podinfo/tags/list
