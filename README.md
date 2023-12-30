# Introduction

This repository serves as an example for using [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) with multi-cluster deployments in different cloud providers.

## Background Knowledge

Before diving into the repository, it's important to understand the following concepts:

- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/): A declarative, GitOps continuous delivery tool for Kubernetes.
- [ArgoCD ApplicationSets](https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/): An Argo CD extension which adds support for new and innovative ways to automatically create Argo CD Applications.
- [ApplicationSet Generators](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Generators/): Generators create a list of Argo CD Applications, based on of parameters that they are provided.

## Directory Structure

The repository is organized as follows:

```bash
├── argocd                              ## rooot argocd directory
│   ├── bootstrap                       ## bootstrap configs ( secrets , projects etc.)
│   │   └── secrets
│   │       ├── clusters                ## clusters as secrets in argocd management cluster
│   │       └── repositories            ## repositories as secrets in argocd management cluster
│   ├── common                          ## common directory for all applications need to deployment through all clusters
│   │   ├── cert-manager
│   │   ├── demo-app
│   │   ├── external-dns
│   │   ├── external-secrets-operator
│   │   └── nginx-ingress-controller
│   ├── envs                            ## deployment environments ( dev, stage , prod etc.)
│   │   ├── dev
│   │   │   └── cert-manager
│   │   ├── stage
│   │   │   ├── cert-manager            ## example app also used as namespace value in the applicationn set
│   │   │   │   ├── aws-values.yaml     ## aws cloud specific values will be merged with default values on the basis of cluster secret labels
│   │   │   │   ├── azure-values.yaml   ## azure cloud specific values will be merged with default values on the basis of cluster secret labels
│   │   │   │   ├── git-generator-overides.json ## git file generator for config management of appset, such as env
│   │   │   │   └── values.yaml         ## Default values used for the app deployments ( best practices )
│   │   │   ├── demo-app
│   │   │   ├── external-dns
│   │   │   ├── external-secrets
│   │   │   └── ingress-nginx-controller
│   │   └── variants                  ## optional variants folder for each cloud providers ( not used in this repo )
│   │       ├── aws
│   │       ├── azure
│   │       └── gcp
│   │
│   └── yamls
├── charts                            ## local charts , in case umbrella or custom chart is needed
│   ├── external-secrets-operator
│   │   ├── charts
│   │   └── templates
└── terraform                         ## just for this repo context , terraform configs for the infra provisioning
```