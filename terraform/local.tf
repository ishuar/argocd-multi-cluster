locals {
  prefix = var.prefix != "" ? var.prefix : "argocd-cluster"
  tags = merge(
    {
      managed_by      = "terraform"
      gitops_operator = "argocd"
      environment     = "dev"
      github_repo     = "ishuar/argocd-multi-cluster"
    },
  var.tags)

  ## Workload Identities
  external-secrets-operator = [
    {
      service_account_name = "sa-external-secrets-operator"
      namespace            = "external-secrets"
      role_assignments = [
        {
          role_definition_name = "Key Vault Secrets User"
          scope                = azurerm_key_vault.aks.id
        },
      ]
    },
  ]
  external-dns = [
    {
      service_account_name = "sa-external-dns"
      namespace            = "external-dns"
      role_assignments = [
        {
          role_definition_name = "DNS Zone Contributor"
          scope                = azurerm_dns_zone.stage_learndevops_in.id
        },
      ]
    },
  ]
  cert-manager = [
    {
      service_account_name = "sa-cert-manager"
      namespace            = "cert-manager"
      role_assignments = [
        {
          role_definition_name = "DNS Zone Contributor"
          scope                = azurerm_dns_zone.stage_learndevops_in.id
        },
      ]
    },
  ]

  identities = concat(
    local.external-secrets-operator,
    local.external-dns,
    local.cert-manager,
  )

}
