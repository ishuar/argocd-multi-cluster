## Special Information

This directory is managed via `argocd` using [argocd-bootstrap-app.yaml](../../helmfile/values/argocd-bootstrap-app.yaml). The bootstrap application uses another applicationset to watch over this directory of applicationsets.

Furthermore these applicationsets configures applications on the basis of [applicationset generators](https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/).

Complete relation ship model is as below:

```mermaid
flowchart TD
    A[["helmfile"]] -- helm release --> B((("ArgoCD"))) & C{{"argocd-bootstrap-appset"}}
    B <-.-> C
    C -- secrets --> D{{"clusters-bootstrap-appset"}}
    C -- workloads --> E{{"workload-bootstrap-appset"}}
    D -- clusters --> F(["dev-cluster"]) & G(["stage-cluster"])
    E -- applicationset --> H(["cert-manager"]) & I(["external-secrets"]) & J(["demo-app"]) & K(["external-secrets-operator"]) & L(["ingress-nginx-controller"])
    style A stroke-width:2px,stroke-dasharray: 0,fill:#000000,stroke:#AA00FF,color:#FFD600
    style B stroke:#FF6D00,color:#FFD600
    style C fill:#2962FF
    style D fill:#2962FF
    style E fill:#2962FF
    style F color:#FF6D00,stroke:#FFD600
    style G color:#FF6D00,stroke:#FFD600
    style H stroke:#FFD600,color:#FF6D00
    style I stroke:#FFD600,color:#FF6D00
    style J stroke:#FFD600,color:#FF6D00
    style K stroke:#FFD600,color:#FF6D00
    style L stroke:#FFD600,color:#FF6D00
    linkStyle 0 stroke:#00C853,fill:none
    linkStyle 1 stroke:#00C853,fill:none
    linkStyle 3 stroke:#AA00FF,fill:none
    linkStyle 4 stroke:#AA00FF,fill:none
    linkStyle 5 stroke:#FF6D00,fill:none
    linkStyle 6 stroke:#FF6D00,fill:none
    linkStyle 7 stroke:#FF6D00,fill:none
    linkStyle 8 stroke:#FF6D00,fill:none
    linkStyle 9 stroke:#FF6D00,fill:none
    linkStyle 10 stroke:#FF6D00,fill:none
    linkStyle 11 stroke:#FF6D00,fill:none
```

> :info: Update client IDs and tenant ID in all `values.yaml` and `cluster-issuer.yaml` :info:
