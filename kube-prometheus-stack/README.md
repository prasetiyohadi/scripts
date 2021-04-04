# Kube-prometheus-stack

## Getting Started

* add helm repository
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

* create prometheus namespace
```
kubectl create namespace prometheus
```

* install kube-prometheus-stack helm Chart
```
helm install --namespace prometheus kube-prometheus prometheus-community/kube-prometheus-stack
```
