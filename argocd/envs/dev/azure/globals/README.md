
## Special Notes

**ONLY INFORMATIVE FILE**


We can avoid per region values.yaml file per application if we define the globals here and merge with region values **BUT** this will impact the app in all of the clusters within the azure cloud provider across the enviornment ( staging ).

Example would be in this directory we could have

- `cert-manager-values.yaml`
- `external-dns-values.yaml`
[...]
