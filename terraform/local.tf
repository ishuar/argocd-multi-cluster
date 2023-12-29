locals {
  prefix = "argocd-cluster"
  tags = {
    managed_by      = "terraform"
    gitops_operator = "argocd"
    environment     = "dev"
    github_repo     = "ishuar/argocd-multi-cluster"
  }
}
