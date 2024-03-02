## For enabling SSO on Argocd with GitHub organization.
## https://argo-cd.readthedocs.io/en/stable/operator-manual/user-management/#1-register-the-application-in-the-identity-provider
resource "azurerm_key_vault_secret" "github_oauth_client_secret" {
  count        = var.dex_github_client_secret != "" ? 1 : 0
  name         = "dex-github-client-secret"
  content_type = "client_secret"
  key_vault_id = azurerm_key_vault.aks.id
  value        = var.dex_github_client_secret
  depends_on = [
    azurerm_role_assignment.kv_rbac
  ]
}
