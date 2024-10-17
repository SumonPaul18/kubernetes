# Basic Working with Kubernetes

### We can generate YAML files for a simple pod and a deployment using `imperative` commands with `kubectl`.
#### Generate YAML for a Simple Pod
Here’s how you can do it:
```
kubectl run nginx-pod --image=nginx -o yaml --dry-run=client > nginx-pod.yaml
```
#### Applying the YAML Files
```
kubectl apply -f nginx-pod.yaml
```
#### Verifying the Pod 
```
kubectl get pod
```
#### Generate YAML for a Deployment
```
kubectl create deployment nginx-deploy --image=nginx -o yaml --dry-run=client > nginx-deploy.yaml
```
#### Applying the YAML Files
```
kubectl apply -f nginx-deploy.yaml
```
#### Verifying the Deployment 
```
kubectl get deployment
```
---
### You can change the image of a running `deployment` or pod using the `kubectl` set image command.
#### Update Pod Image
```
kubectl set image pod/nginx-pod nginx=nginx:1.19.0
```
#### Verify the Update
```
kubectl describe pod nginx-pod
```
#### Update Deployment Image
```
kubectl set image deployment/nginx-deploy nginx=nginx:1.19.0
```
#### Verify the Update
```
kubectl describe deployment nginx-deploy
```
---
### To perform a rolling update or rollback in Kubernetes, you can use the kubectl command-line tool. 

### Rolling Update
A rolling update allows you to update your application without downtime by incrementally replacing old pods with new ones.

1. **Update Deployment Image**:
   For example:
   ```sh
   kubectl set image deployment/nginx-deploy nginx=nginx:1.19.0
   ```

2. **Check Rollout Status**:
   Monitor the status of the rollout to ensure it completes successfully:
   ```sh
   kubectl rollout status deployment/nginx-deploy
   ```

### Rollback
If you need to revert to a previous version of your deployment, you can use the rollback feature.

1. **Rollback Deployment**:
   Roll back to the previous revision:
   ```sh
   kubectl rollout undo deployment/nginx-deploy
   ```

2. **Rollback to a Specific Revision**:
   If you need to roll back to a specific revision, you can specify the revision number:
   ```sh
   kubectl rollout undo deployment/nginx-deploy --to-revision=<revision-number>
   ```

3. **Check Rollout History**:
   View the rollout history to find the revision numbers:
   ```sh
   kubectl rollout history deployment/nginx-deploy
   ```
---

