<!-- PROJECT SHIELDS -->
<!--
*** declarations on the bottom of this document
managed within the footer file
-->
[![License][license-shield]][license-url] [![Contributors][contributors-shield]][contributors-url] [![Issues][issues-shield]][issues-url] [![Forks][forks-shield]][forks-url] [![Stargazers][stars-shield]][stars-url]

<div id="top"></div>
<!-- PROJECT LOGO -->
<br />
<div align="center">

  <h1 align="center"><strong>Deploy Applications in Multi-Cluster with ArgoCD</strong></h1>
  <p align="center">
    🌩️ How to deploy applications in an multi-cluster environment distributed across multiple clouds using ArgoCd and its native operators.🌩️
    <br/>
    <a href="https://github.com/ishuar/argocd-multi-cluster/issues"><strong>Report Bug</a></strong> or <a href="https://github.com/ishuar/argocd-multi-cluster/issues"><strong>Request Feature</a></strong>
    <br/>
    <br/>
  </p>
</div>

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

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have any suggestion that would make this project better, feel free to  fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement" with your suggestion.


**⭐️ Don't forget to give the project a star! Thanks again! ⭐️**

<!-- LICENSE -->
## License

Released under [MIT](/LICENSE) by [@ishuar](https://github.com/ishuar).

<!-- CONTACT -->
## Contact

- 👯 [LinkedIn](https://linkedin.com/in/ishuar)

<p align="right"><a href="#top">Back To Top ⬆️</a></p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-url]: https://github.com/ishuar/argocd-multi-cluster/graphs/contributors
[contributors-shield]: https://img.shields.io/github/contributors/ishuar/argocd-multi-cluster?style=for-the-badge

[forks-url]: https://github.com/ishuar/argocd-multi-cluster/network/members
[forks-shield]: https://img.shields.io/github/forks/ishuar/argocd-multi-cluster?style=for-the-badge

[stars-url]: https://github.com/ishuar/argocd-multi-cluster/stargazers
[stars-shield]: https://img.shields.io/github/stars/ishuar/argocd-multi-cluster?style=for-the-badge

[issues-url]: https://github.com/ishuar/argocd-multi-cluster/issues
[issues-shield]: https://img.shields.io/github/issues/ishuar/argocd-multi-cluster?style=for-the-badge

[license-url]: https://github.com/ishuar/argocd-multi-cluster/blob/main/LICENSE
[license-shield]: https://img.shields.io/github/license/ishuar/argocd-multi-cluster?style=for-the-badge