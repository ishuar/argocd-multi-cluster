output "client_ids" {
  value = {
    for k, v in module.workload_identity : k => v.client_id
  }
  description = "The IDs of the apps associated with the Identities in a servie account as key and client ID as a value format."
}

output "subjects" {
  value = {
    for k, v in module.workload_identity : k => v.subject
  }
  description = "The subjects for the Federated Identity Credential associated with the Identities"
}

output "client_id_used_by_external_secrets_operator" {
  value       = module.workload_identity["sa-external-secrets-operator"].client_id
  description = "Value of client_id used by External Secrets Operator."
}

output "client_id_used_by_argocd" {
  value       = azurerm_user_assigned_identity.argocd.client_id
  description = "Value of client_id used by ArgoCD to manage remote clusters."
}

output "remote_cluster_ca_certificate_base_64" {
  value       = data.azurerm_kubernetes_cluster.remote.kube_config.0.cluster_ca_certificate
  sensitive   = true
  description = "The base64 encoded certificate authority data for the remote cluster."
}

output "tenant_id" {
  value       = data.azurerm_subscription.current.tenant_id
  description = "The tenant ID of the current Azure account."
}

output "secrets_key_vault_url" {
  value       = azurerm_key_vault.aks.vault_uri
  description = "The URL of the Key Vault created for the AKS cluster."
}

output "dns_zone_name_servers" {
  value       = azurerm_dns_zone.stage_learndevops_in.name_servers
  description = "The name servers for the DNS Zone."
}
