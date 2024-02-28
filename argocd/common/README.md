## Special Information

I applied all these app set locally on the ArgoCd management cluster. Can use Apps of Apps pattern here.
or
One app set with git generator looping over all the apps inside the common directory.

Commands used:

```bash
$ cd argocd/common
$ kubectl apply -f external-secrets-operator/applicationset.yaml
$ kubectl apply -f external-dns/applicationset.yaml
$ kubectl apply -f nginx-ingress-controller/applicationset.yaml
$ kubectl apply -f cert-manager/applicationset.yaml
$ kubectl apply -f demo-app/applicationset.yaml
```
