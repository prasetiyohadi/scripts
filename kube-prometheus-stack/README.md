# Kube-prometheus-stack

Kube-prometheus-stack [Helm Chart page](https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/README.md)

## Getting Started

* Add Helm repo
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

* Create namespace
```
kubectl create namespace prometheus
```

* Install kube-prometheus-stack chart
```
helm install --namespace prometheus prometheus prometheus-community/kube-prometheus-stack
```

* Use values from the file ingress/values.yml to enable ingress
```
export HOST=<ingress_domain>
sed -i "s/HOST/$HOST/g" ingress/values.yml
helm install --namespace prometheus prometheus prometheus-community/kube-prometheus-stack --values ingress/values.yml
```

## Note for ARM/ARM64 Support

Github issue: https://github.com/prometheus-community/helm-charts/issues/373

* Install kube-prometheus-stack chart in ARM/ARM64
```
helm install --namespace prometheus prometheus prometheus-community/kube-prometheus-stack --values arm/values.yml
```
