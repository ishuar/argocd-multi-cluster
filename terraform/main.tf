data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}


resource "azurerm_resource_group" "aks" {
  name     = "rg-${local.prefix}"
  location = "North Europe"
  tags     = local.tags
}
####### ---------------------------------------------------------- #######

## Create group for admins
resource "azuread_group" "aks_cluster_admins" {
  display_name     = "${local.prefix}-cluster-admins"
  owners           = [data.azurerm_client_config.current.object_id]
  security_enabled = true

  members = [
    data.azurerm_client_config.current.object_id,
  ]
}

## Assign cluster admin role to admins group
resource "azurerm_role_assignment" "cluster_admin" {
  scope                = module.argocd.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = azuread_group.aks_cluster_admins.object_id
}

####### ---------------------------------------------------------- #######

module "ssh_key_generator" {
  source               = "github.com/ishuar/terraform-sshkey-generator?ref=v1.1.0"
  algorithm            = "RSA"
  private_key_filename = "${path.module}/aks-private-key" # add this path to your gitignore
  file_permission      = "600"
}

resource "azurerm_user_assigned_identity" "aks" {
  name                = "id-${local.prefix}"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

resource "azurerm_role_assignment" "aks_mi_network_contributor" {
  scope                = azurerm_resource_group.aks.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

module "argocd" {
  source  = "ishuar/aks/azure"
  version = "2.3.0"

  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  name                = "${local.prefix}-aks"
  dns_prefix          = var.argocd_aks_dns_prefix
  key_data            = trimspace(module.ssh_key_generator.public_ssh_key)
  tags                = local.tags

  ## Identity
  identity_type = "UserAssigned"
  identity_ids  = [azurerm_user_assigned_identity.aks.id]

  ## Default node pool
  default_node_pool_name                = "system"
  default_node_pool_enable_auto_scaling = true
  default_node_pool_vm_size             = "standard_d2ds_v4"
  default_node_pool_min_count           = 1
  default_node_pool_max_count           = 2
  default_node_pool_max_pods            = 110

  ## Api service access profile
  enable_api_server_access_profile    = true
  vnet_integration_enabled            = true
  api_server_access_profile_subnet_id = azurerm_subnet.aks_api.id

  ## Networking
  vnet_subnet_id      = azurerm_subnet.aks_node.id
  network_plugin      = "azure"
  network_plugin_mode = "overlay"
  service_cidrs       = ["100.1.0.0/16"]
  pod_cidrs           = ["100.2.0.0/16"]
  dns_service_ip      = "100.1.0.100"
  network_policy      = "calico"
  # ebpf_data_plane     = "cilium"

  ## Azure Active Directory
  local_account_disabled           = true
  aad_rbac_enabled                 = true ## Enable the feature for Azure RBAC with AKS
  aad_rbac_managed                 = true ## Manged RBAC
  aad_azure_rbac_enabled           = true ## Azure AAD and Azure RBAC ( No K8s RBAC )
  aad_rbac_managed_admin_group_ids = [azuread_group.aks_cluster_admins.object_id]

  ## Workload Identity
  workload_identity_enabled = true
  oidc_issuer_enabled       = true

  ## Flux
  enable_fluxcd = false
  depends_on = [
    azurerm_role_assignment.aks_mi_network_contributor,
  ]
}
