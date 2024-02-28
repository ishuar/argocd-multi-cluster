## Why Helmfile?

While deploying these HelmReleases with `Terraform` is a viable option and aligns with the principle of "less is more" in managing technical debt, I've made a deliberate choice in favor of `Helmfile`. This decision is driven by the need for increased visibility, better control, and reduced maintenance durations. Unlike Terraform, Helmfile provides a more robust diff mechanism, allowing for a detailed comparison of changes in Helm releases. Terraform, in contrast, lacks comprehensive insights into Helm release differences, particularly in cases where there is a drop in value file. Helmfile emerges as a superior alternative, addressing these limitations and enhancing the overall deployment experience.

- More on [Helmfile](https://helmfile.readthedocs.io/en/latest/).


```bash
## helpful for first install to skip CRDs dependency.
$ helmfile apply --skip-diff-on-install --interactive
$ helmfile diff
$ helmfile sync
```


## Expected Errors

1. Below error is expected when you choose (type `y`) to proceed after `helmfile apply --skip-diff-on-install --interactive` for the **very first run**.

```bash
STDERR:
  Error: unable to build kubernetes objects from release manifest: resource mapping not found for name: "azure-cluster-secret-store" namespace: "" from "": no matches for kind "ClusterSecretStore" in version "external-secrets.io/v1beta1"
  ensure CRDs are installed first

COMBINED OUTPUT:
  Release "external-secrets" does not exist. Installing it now.
  Error: unable to build kubernetes objects from release manifest: resource mapping not found for name: "azure-cluster-secret-store" namespace: "" from "": no matches for kind "ClusterSecretStore" in version "external-secrets.io/v1beta1"
  ensure CRDs are installed first
```

The error is because of missing CRDs required for the custom [`external-secrets-operator`](../charts/external-secrets-operator/) helm chart's resource `ClusterSecretStore`.

To fix this error set `clusterSecretStore.enabled` to `false` in [`external-secrets-operator/values.yaml`](./values/external-secrets.yaml) and then apply helmfile using `helmfile apply -i`.

After successfull apply set `clusterSecretStore.enabled` to `true` and re-apply helmfile using `helmfile apply -i`.