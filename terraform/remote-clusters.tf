locals {
  service_accounts = ["sa-argocd-application-controller", "sa-argocd-server"]
}

## It is assumed that the remote cluster is already created, create new if does not exists and use the inputs accordingly.
## Generally new cluster creation/config should be moved to another directory for better maintainability.
## Treat this as a demo ( simmple used case and adapt as per your needs)

data "azurerm_kubernetes_cluster" "remote" {
  name                = var.remote_cluster_name
  resource_group_name = var.remote_cluster_resource_group_name
}

## Identity to add remote cluster to the ArgoCD managed clusters as secrets.
## Dedicated file and Configuration because on one UID we are mapping two service accounts.

resource "azurerm_user_assigned_identity" "argocd" {
  name                = "${local.prefix}-remote-uid-001"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  tags                = merge({ used_by = "argocd" }, local.tags)
}

resource "azurerm_federated_identity_credential" "argocd" {
  for_each            = toset(local.service_accounts) ##! Use these name for Argocd server and app controller service accounts
  name                = "${(each.value)}-fed-creds"
  resource_group_name = azurerm_user_assigned_identity.argocd.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.this.oidc_issuer_url ## using the argocd cluster oidc issuer url
  parent_id           = azurerm_user_assigned_identity.argocd.id
  subject             = "system:serviceaccount:argocd:${each.value}"
}

resource "azurerm_role_assignment" "remote_cluster_admin" {
  role_definition_name = var.role_definition_name
  scope                = data.azurerm_kubernetes_cluster.remote.id
  principal_id         = azurerm_user_assigned_identity.argocd.principal_id
  description          = "Role assignment for ArgoCD deployed in ${data.azurerm_kubernetes_cluster.this.name} AKS cluster to manage remote AKS clusters"
}

##? Push the generated secrets to keyvault as secret to be used by the ArgoCD server and application controller.
##? Used in the Cluster Secret ../argocd/bootstrap/clusters/azure-north-europe-stage-01 via external secrets controller.

resource "azurerm_key_vault_secret" "remote_cluster" {
  for_each = {
    tenantid          = data.azurerm_client_config.current.tenant_id
    argocdclientid    = azurerm_user_assigned_identity.argocd.client_id
    remoteclustercert = data.azurerm_kubernetes_cluster.remote.kube_config.0.cluster_ca_certificate
  }

  name         = each.key
  content_type = "generic"
  key_vault_id = azurerm_key_vault.aks.id
  value        = each.value
  depends_on = [
    azurerm_role_assignment.kv_rbac
  ]
}
