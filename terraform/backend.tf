## This config is generated using script in ../scripts/create-tf-backend.sh
## Please run the script to generate the backend config for your environment with appropriate env vars.

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-argocd-multi-cluster-backend-001"
    storage_account_name = "stgargok8sneu01"
    container_name       = "argocd-multi-cluster"
    key                  = "terraform.tfstate"
  }
}
