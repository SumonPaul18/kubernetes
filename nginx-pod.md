# Kubernets Operation
Check API Version of Kubernetes

    kubectl api-resources | grep pods

apiVersion: v1
Kind: Pod
metadata:
  name: nginx-pod1
  labels:
    team: integrations
    app: todo
spec:
