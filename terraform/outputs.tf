output "client_certificate_base_64" {
  value       = data.azurerm_kubernetes_cluster.this.kube_config
  description = "value of client_certificate_base_64"
  sensitive   = true
}

# output "argocd_workload_identity_client_id" {
#   value       = module.argocd_workload_identity.client_id
#   description = "value of argocd_workload_identity_client_id"
# }

output "client_ids" {
  value       = { for k, v in module.workload_identity : k => v.client_id }
  description = "The IDs of the apps associated with the Identities"
}

output "subjects" {
  value       = { for k, v in module.workload_identity : k => v.subject }
  description = "The subjects for the Federated Identity Credential associated with the Identities"
}