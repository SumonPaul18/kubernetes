# Basic Working with Kubernetes
## We can generate YAML files for a simple pod using imperative commands with kubectl. 
Here’s how you can do it:
```
kubectl run nginx-pod --image=nginx -o yaml --dry-run=client > nginxpod.yaml
```
## We can generate YAML files for a simple Deployment using imperative commands with kubectl. 
```
kubectl create deployment nginx-deploy --image=nginx -o yaml --dry-run=client > nginx-deploy.yaml
```
