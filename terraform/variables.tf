variable "tenant_id" {
  type        = string
  description = "(Required) Tenant ID where the Azure subscriptions exist."
}

variable "key_vault_name" {
  type        = string
  description = "(optional) Name of the Key Vault to create. This value should be globally unique across Azure."
  default     = "superuniquekv001"
}

variable "prefix" {
  type        = string
  description = "(optional) Prefix for naming resources"
  default     = "argocd-cluster"
}

variable "tags" {
  type        = map(string)
  description = "(optional) Tags to apply to all resources."
  default     = {}
}

## Network ###

variable "argocd_aks_dns_prefix" {
  type        = string
  description = "(optional) DNS prefix for AKS cluster used for ArgoCD."
  default     = "aks-argocd"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "(optional) Address space for the virtual network used for AKS."
  default     = ["10.0.0.0/16"]
}

variable "node_subnet_address_prefixes" {
  type        = list(string)
  description = "(optional) Address spaces for the subnets used for AKS nodes."
  default     = ["10.0.1.0/24"]
}

variable "api_subnet_address_prefixes" {
  type        = list(string)
  description = "(optional) Address spaces for the subnets used for AKS API server."
  default     = ["10.0.2.0/24"]
}

variable "dns_zone_name" {
  type        = string
  description = "(optional) DNS zone where you will expose your services. you need to own this domain to delegate to azure public DNS created by this module."
  default     = "example.yourdomain.com"
}

## Remote Cluster ###

variable "remote_cluster_name" {
  type        = string
  description = "(Required) Name of the remote cluster which needs to be added to ArgoCD using workload Identity. The UID used should have access to the remote cluster as per required actions."
}

variable "remote_cluster_resource_group_name" {
  type        = string
  description = "(Required) Resource group name of the remote cluster which needs to be added to ArgoCD using workload Identity."
}

variable "role_definition_name" {
  type        = string
  description = "(optional) Role definition name to assign to the workload identity used by ArgoCD to manage remote cluster. Default value is Azure Kubernetes Service RBAC Cluster Admin."
  default     = "Azure Kubernetes Service RBAC Cluster Admin"
}
