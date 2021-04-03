# AWX

## Getting Started

* install AWX operator
```
kubectl apply -f https://raw.githubusercontent.com/ansible/awx-operator/devel/deploy/awx-operator.yaml
```

* create an AWX instance
```
vi awx.yaml
```

* get the AWX admin password
```
kubectl get secrets awx-admin-password -o jsonpath='{.data.password}' | base64 -d
```
