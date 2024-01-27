#! /usr/bin/env bash

# https://mywiki.wooledge.org/BashFAQ/105 :: ref to "So-called strict mode"
set -euo pipefail

##* This script creates the terraform backend for azure, storage acccount and contaier for terraform remote state.
##* below variables can be set on the runtime by using `export <VARIABLE_NAME>=<VALUE>`

LOCATION=${LOCATION:-"northeurope"}
RESOURCE_GROUP_NAME=${RESOURCE_GROUP_NAME:-"rg-argocd-multi-cluster-backend-001"}
STORAGE_ACCOUNT_NAME=${1:-"stgargok8sneu01"}
CONTAINER_NAME=${CONTAINER_NAME:-"argocd-multi-cluster"}
KEY_NAME=${KEY_NAME:-"terraform.tfstate"}

export LOCATION
export RESOURCE_GROUP_NAME
export STORAGE_ACCOUNT_NAME
export KEY_NAME
export CONTAINER_NAME

## https://github.com/ishuar/bash-scripts/blob/main/create-terraform-azure-remote-backend.sh
bash <(curl -s https://raw.githubusercontent.com/ishuar/bash-scripts/main/create-terraform-azure-remote-backend.sh)
