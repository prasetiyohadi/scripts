# Sealed-secrets

## Getting Started

* create working directory
```
mkdir -p sealed-secrets
cd sealed-secrets
```

* create base directory
```
mkdir -p base
```

* create base/kustomization.yaml file
```
vi base/kustomization.yaml
```

* test kustomize
```
kustomize build base
```

* download sealed-secrets controller
```
export URL=https://github.com/bitnami-labs/sealed-secrets/releases/
export URL=${URL}/download/v0.14.1/controller.yaml
wget ${URL} -O base/controller.yaml
```

* check base/controller.yaml file
```
vi base/controller.yaml
kustomize build base
```

* update base/kustomization.yaml file
```
vi base/kustomization.yaml
kustomize build base
```

* apply kustomize output
```
kustomize build base | kubectl apply --filename -
```

* get pods
```
kubectl get all -n sealed secrets
kubectl get all -n sealed-secrets
kubectl get pod -n sealed secrets
```

* get ingress
```
kubectl get ingresses -A
kubectl -n sealed-secrets get ingresses
kubectl --namespace argo get ingresses
kubectl --namespace sealed-secrets get ingresses
```

* get namespaces
```
kubectl get namespaces
```

* create test-secrets namespace
```
kubectl create namespace test-secrets
```

* try to simulate create secret
```
kubectl --namespace test-secrets create secret generic mysecret \
--dry-run=client --from-literal foo=bar --output json
```

* pipe the simulation result to kubeseal
```
kubectl --namespace test-secrets create secret generic mysecret \
--dry-run=client --from-literal foo=bar --output json | kubeseal \
--controller-namespace=sealed-secrets
```

* pipe the simulation result to kubeseal with yaml format
```
kubectl --namespace test-secrets create secret generic mysecret \
--dry-run=client --from-literal foo=bar --output json | kubeseal \
--controller-namespace=sealed-secrets -o yaml
```

* pipe the kubeseal output to mysecret.yaml
```
kubectl --namespace test-secrets create secret generic mysecret \
--dry-run=client --from-literal foo=bar --output json | kubeseal \
--controller-namespace=sealed-secrets -o yaml | tee mysecret.yaml
```

* try to simulate to create resource using mysecret.yaml
```
kubectl create --filename mysecret.yaml --dry-run=client
```

* create resource using mysecret.yaml
```
kubectl create --filename mysecret.yaml
```

* get sealedsecrets resource
```
kubectl -n test-secrets get sealedsecrets.bitnami.com
```

* get sealedsecrets resource mysecret
```
kubectl -n test-secrets get sealedsecrets.bitnami.com mysecret
```

* output sealedsecrets resource mysecret in yaml format
```
kubectl -n test-secrets get sealedsecrets.bitnami.com mysecret -o yaml
```

* output sealedsecrets resource mysecret in json format
```
kubectl -n test-secrets get sealedsecrets.bitnami.com mysecret -o json
```

* get secrets resource
```
kubectl -n test-secrets get secrets
```

* output secrets resource mysecret in yaml format
```
kubectl -n test-secrets get secrets mysecret --output yaml
```

* output a value from secrets resource mysecret in jsonpath format
```
kubectl -n test-secrets get secrets mysecret \
--output jsonpath="{.data.foo}"
```

* decode base64 a value from secrets resource mysecret in jsonpath format
```
kubectl -n test-secrets get secrets mysecret \
--output jsonpath="{.data.foo}" | base64 --decode && echo
```

* fetch sealed-secrets controller certificate
```
kubeseal --controller-namespace=sealed-secrets --fetch-cert
```
