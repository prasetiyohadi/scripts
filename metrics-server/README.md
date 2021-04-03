# Metrics-server

## Getting Started

* install helm repository
```
helm repo add bitnami https://charts.bitnami.com/bitnami
```

* create metrics-server namespace
```
kubectl create namespace metrics-server
```

* create metrics-server configuration values file for your installation (i.e. linode)
```
vi linode.yaml
```

* install helm Chart
```
helm install -n metrics-server metrics-server bitnami/metrics-server -f linode.yaml
```

* get all resources in metrics-server namespace
```
kubectl -n metrics-server get all -owide
```
