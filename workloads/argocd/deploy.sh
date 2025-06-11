#!/bin/bash

BASEDIR=$(dirname "$(realpath "$0")")

helm install argo-cd https://argoproj.github.io/argo-helm

$ helm install my-release argo/argo-cd
NAME: my-release
...