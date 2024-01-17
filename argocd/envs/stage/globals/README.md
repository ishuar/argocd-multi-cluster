## Special Notes

**ONLY INFORMATIVE FILE**

We can avoid per region values.yaml file per application if we define the globals here and merge with region values **BUT** this will impact the app in the all cloud providers across the enviornment ( staging ).

Basically we can have completely cloud agnostic application configuration if the risk is acceptable.

Example would be in this directory we could have

- `cert-manager-values.yaml`
- `external-dns-values.yaml`
[...]
