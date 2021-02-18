# Kubeseal

## Install

### Client side

Use `kubeseal.sh` script.

### Cluster side

Install SealedSecret CRD, server-side controller into kube-system namespace.

```
$ kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/$KUBESEAL_VERSION/controller.yaml
```

NOTE: If you can't (or don't want) to use the kube-system namespace, please consider [this approach](https://github.com/bitnami-labs/sealed-secrets#kustomize)

NOTE: if you want to install it on a GKE cluster for which your user account doesn't have admin rights, please read [this](https://github.com/bitnami-labs/sealed-secrets/blob/master/docs/GKE.md)

NOTE: since the helm chart is currently maintained elsewhere (see [https://github.com/helm/charts/tree/master/stable/sealed-secrets](https://github.com/helm/charts/tree/master/stable/sealed-secrets) the update of the helm chart might not happen in sync with releases here.
