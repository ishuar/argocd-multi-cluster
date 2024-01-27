## Why Helmfile?

While deploying these HelmReleases with `Terraform` is a viable option and aligns with the principle of "less is more" in managing technical debt, I've made a deliberate choice in favor of `Helmfile`. This decision is driven by the need for increased visibility, better control, and reduced maintenance durations. Unlike Terraform, Helmfile provides a more robust diff mechanism, allowing for a detailed comparison of changes in Helm releases. Terraform, in contrast, lacks comprehensive insights into Helm release differences, particularly in cases where there is a drop in value file. Helmfile emerges as a superior alternative, addressing these limitations and enhancing the overall deployment experience.

- More on [Helmfile](https://helmfile.readthedocs.io/en/latest/).