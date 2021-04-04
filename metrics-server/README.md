# Metrics-server

## Getting Started

### Install metrics-server from kubernetes-sigs repository

* install metrics server using kubectl
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### Install metrics-server from Bitnami Helm Charts repository

* install helm repository
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

* create metrics-server namespace
```
kubectl create namespace metrics-server
```

* create metrics-server configuration values file for your installation (i.e. linode)
```
vi linode.yaml
```

* check pod resource usage
```
kubectl top pod <pod_name>
```

* install helm Chart
```
helm install -n metrics-server metrics-server bitnami/metrics-server -f linode.yaml
```

* get all resources in metrics-server namespace
```
kubectl -n metrics-server get all -o wide
```

## Troubleshooting

### Install metrics-server in kubernetes in docker (kind) cluster

* Github issue: https://github.com/kubernetes-sigs/kind/issues/398

* kubernetes deployment using kind (kubernetes in docker) needs the following
  configuration for the metrics-server container
```
    args:
        - --kubelet-insecure-tls
        - --kubelet-preferred-address-types=InternalIP
```

* update the metrics-server installation manifest for kind cluster or patch
  using kubectl
```
kubectl patch deployment metrics-server -n kube-system --type json \
    -p '[{"op": "replace", "path": "/spec/template/spec/containers/0/args",
    "value": [
        "--cert-dir=/tmp",
        "--secure-port=4443",
        "--kubelet-insecure-tls",
        "--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
        "--kubelet-use-node-status-port"
    ]}]'
```
