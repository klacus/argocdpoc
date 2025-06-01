#!/bin/bash

# See lab configuration in the file referenced below.
source ../configuration.sh

# Download Custom Resource Definitions.
# curl -O -L https://github.com/cert-manager/cert-manager/releases/download/v1.17.1/cert-manager.crds.yaml

# Download cert-manager helm chart.
curl -O -L https://charts.jetstack.io/charts/cert-manager-v1.17.2.tgz

# remove old folder and content of cert-manager 
rm -R ./cert-manager

# Extracting cert-manager helm chart files.
tar -xvzf ./cert-manager-v1.17.1.tgz

# Uninstall existing cert-manager and CRDs if exist.
echo "Uninstalling cert-manager ..."
helm uninstall cert-manager --namespace ${CERT_MANAGER_NAMESPACE} --wait
echo "Uninstalling cert-manager done"

# echo "Uninstalling CRDs ..."
# kubectl delete -f ./cert-manager.crds.yaml -n ${CERT_MANAGER_NAMESPACE} --wait
# echo "Cert-manager and CRDs uninstalled."

# Install cert manager with the custom value files
echo "Installing cert manager ..."
kubectl apply -f ./namespace.yaml
helm upgrade --install --namespace ${CERT_MANAGER_NAMESPACE} --create-namespace --wait -f ./values-custom.yaml cert-manager ./cert-manager
echo "Cert-manager installed."

# Bootstrapping CA cert 
echo "Creating Root CA ..."
kubectl apply -f ./selfsigned-ca.yaml -n ${CERT_MANAGER_NAMESPACE} --wait
echo "Creating Root CA done."

echo "Waiting 60 seconds for the certificates properly created ..."
sleep 60

# export root CA so it can be imported to local OS and browsers.
echo "Exporting certificates"
kubectl get secret root-secret -n ${CERT_MANAGER_NAMESPACE} -o go-template='{{index .data "ca.crt" | base64decode}}}' > argocdpoc-ca.crt
kubectl get secret root-secret -n ${CERT_MANAGER_NAMESPACE} -o go-template='{{index .data "tls.crt" | base64decode}}}' > argocdpoc-tls.crt
kubectl get secret root-secret -n ${CERT_MANAGER_NAMESPACE} -o go-template='{{index .data "tls.key" | base64decode}}}' > argocdpoc-tls.key

# Add Root CA to local machine trusted certs
echo "Adding Root CA to local machine trusted certs ..."
sudo cp ./argocdpoc-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
echo .
echo .
echo .
echo "!!! Do not forget to import the ./labk3s-ca.crt certificate to your browser! !!!"
echo .
echo .
echo .

# Installing Trust Manager
# https://cert-manager.io/docs/trust/trust-manager/

# uninstall Trust Manager if needed

# install trust manager

echo !!!
echo !!!
echo !!!
echo If you have docker running, you will need to restart it to pick up the new CA certificate.
echo "sudo systemctl restart docker.service"
sudo systemctl restart docker.service
echo !!!
echo !!!
echo !!!

echo "Done."
