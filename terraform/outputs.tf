output "client_certificate_base_64" {
  value       = data.azurerm_kubernetes_cluster.this.kube_config
  description = "value of client_certificate_base_64"
  sensitive   = true
}

output "argocd_workload_identity_client_id" {
  value       = module.argocd_workload_identity.client_id
  description = "value of argocd_workload_identity_client_id"
}
