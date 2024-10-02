# Kubectl Cheat Sheet

```markdown
# Kubernetes Commands

## Cluster Information
Get cluster information:
```sh
kubectl cluster-info
```

## Node Operations
List all the nodes:
```sh
kubectl get nodes
```

Describe a specific node:
```sh
kubectl describe node <node-name>
```

Drain a node for maintenance:
```sh
kubectl drain <node>
```

Add labels to a node:
```sh
kubectl label nodes <node-name> <label-key>=<label-value>
```

Mark a node as unschedulable:
```sh
kubectl cordon <node>
```

Mark a node as schedulable again after it has been drained:
```sh
kubectl uncordon <node>
```

Show metrics for a given node:
```sh
kubectl top <node>
```

## Namespace Operations
Describe all namespaces:
```sh
kubectl describe namespace
```

Create a specific namespace:
```sh
kubectl create namespace <namespace-name>
```

List all namespaces:
```sh
kubectl get namespace
```

Shortened version of `kubectl get namespace`:
```sh
kubectl get ns
```

Describe a specific namespace:
```sh
kubectl describe namespace <namespace-name>
```

Switch to a different namespace:
```sh
kubectl config set-context --current --namespace=<namespace-name>
```

Delete a namespace:
```sh
kubectl delete namespace <namespace-name>
```

Edit and update the namespace definition:
```sh
kubectl edit namespace <namespace-name>
```

## Resource Operations
Create or update a resource from a YAML file:
```sh
kubectl apply -f <resource-definition.yaml>
```

Create an object imperatively:
```sh
kubectl create
```

Create a resource by using the URL:
```sh
kubectl apply -f https://url-to-resource-definition.yaml
```

## Viewing and Finding Resources
List all resources of a specific type:
```sh
kubectl get <resource-type>
```

List all resources with additional details:
```sh
kubectl get <resource-type> -o wide
```

Describe a specific resource:
```sh
kubectl describe <resource-type> <resource-name>
```

List all resources with a specific label:
```sh
kubectl get <resource-type> -l <label-key>=<label-value>
```

List all resources in all namespaces:
```sh
kubectl get <resource-type> --all-namespaces
```

List all resources sorted by a specific field:
```sh
kubectl get <resource-type> --sort-by=<field>
```

List resources with a specific label selector:
```sh
kubectl get <resource-type> -l <label-selector>
```

List resources with a specific field selector:
```sh
kubectl get <resource-type> --field-selector=<field-selector>
```

List all resources in a specific namespace:
```sh
kubectl get <resource-type> -n <namespace>
```

## Deleting Resources
Delete a resource:
```sh
kubectl delete <resource-type> <resource-name>
```

Delete multiple resources:
```sh
kubectl delete <resource-type1> <resource-name1> <resource-type2> <resource-name2>
```

Delete all resources of a specific type:
```sh
kubectl delete <resource-type> --all
```

Delete the resource defined in a YAML file:
```sh
kubectl delete -f <resource-definition.yaml>
```

Delete the resource by using the URL:
```sh
kubectl delete -f https://url-to-resource-definition.yaml
```

Delete all resources in a specific namespace:
```sh
kubectl delete <resource-type> --all -n <namespace>
```

## Pod Operations
List all pods in the cluster:
```sh
kubectl get pods
```

Describe a specific pod:
```sh
kubectl describe pod <pod-name>
```

View the logs of a specific pod:
```sh
kubectl logs <pod-name>
```

Execute a command in a specific pod:
```sh
kubectl exec -it <pod-name> -- <command>
```

## Service Operations
List all services in the cluster:
```sh
kubectl get services
```

Describe a specific service:
```sh
kubectl describe service <service-name>
```

## Deployment Operations
List all deployments in the cluster:
```sh
kubectl get deployments
```

Describe a specific deployment:
```sh
kubectl describe deployment <deployment-name>
```

Scale a deployment:
```sh
kubectl scale deployment <deployment-name> --replicas=<replica-count>
```

View rollout history of a deployment or replicaset:
```sh
kubectl rollout history <resource-type> <resource-name>
```

Rollback a deployment or replicaset to a previous revision:
```sh
kubectl rollout undo <resource-type> <resource-name>
```

View rollout status of a deployment or replicaset:
```sh
kubectl rollout status <resource-type> <resource-name>
```

Temporarily pause the rollout of a deployment or replicaset:
```sh
kubectl rollout pause <resource-type> <resource-name>
```

Resume a paused rollout of a deployment or replicaset:
```sh
kubectl rollout resume <resource-type> <resource-name>
```

## Configuration and Context
List all available contexts:
```sh
kubectl config get-contexts
```

Switch to a different context:
```sh
kubectl config use-context <context-name>
```

## Secret Operations
Create a secret imperatively:
```sh
kubectl create secret
```

List all secrets in the cluster:
```sh
kubectl get secrets
```

Describe a specific secret:
```sh
kubectl describe secret <secret-name>
```

## ConfigMap Operations
Create a ConfigMap imperatively:
```sh
kubectl create configmap
```

List all ConfigMaps in the cluster:
```sh
kubectl get configmaps
```

Describe a specific ConfigMap:
```sh
kubectl describe configmap <configmap-name>
```

## Persistent Volume (PV) and Persistent Volume Claim (PVC) Operations
List all Persistent Volumes in the cluster:
```sh
kubectl get pv
```

Describe a specific Persistent Volume:
```sh
kubectl describe pv <pv-name>
```

List all Persistent Volume Claims in the cluster:
```sh
kubectl get pvc
```

Describe a specific Persistent Volume Claim:
```sh
kubectl describe pvc <pvc-name>
```

## Role-Based Access Control (RBAC) Operations
Create a role imperatively:
```sh
kubectl create role
```

List all roles in the cluster:
```sh
kubectl get roles
```

Describe a specific role:
```sh
kubectl describe role <role-name>
```

Create a role binding imperatively:
```sh
kubectl create rolebinding
```

List all role bindings in the cluster:
```sh
kubectl get rolebindings
```

Describe a specific role binding:
```sh
kubectl describe rolebinding <rolebinding-name>
```

## Ingress Operations
List all ingresses in the cluster:
```sh
kubectl get ingress
```

Describe a specific ingress:
```sh
kubectl describe ingress <ingress-name>
```

## Job and CronJob Operations
List all jobs in the cluster:
```sh
kubectl get jobs
```

Describe a specific job:
```sh
kubectl describe job <job-name>
```

List all cron jobs in the cluster:
```sh
kubectl get cronjobs
```

Describe a specific cron job:
```sh
kubectl describe cronjob <cronjob-name>
```

## Network Policy Operations
List all network policies in the cluster:
```sh
kubectl get networkpolicies
```

Describe a specific network policy:
```sh
kubectl describe networkpolicy <networkpolicy-name>
```

## Namespace Resource Quota Operations
List all resource quotas in a namespace:
```sh
kubectl get resourcequotas
```

Describe a specific resource quota in a namespace:
```sh
kubectl describe resourcequota <resourcequota-name>
```

## Horizontal Pod Autoscaler (HPA) Operations
List all horizontal pod autoscalers in the cluster:
```sh
kubectl get hpa
```

Describe a specific horizontal pod autoscaler:
```sh
kubectl describe hpa <hpa-name>
```

## Event Operations
List all events in the cluster:
```sh
kubectl get events
```

Describe a specific event:
```sh
kubectl describe event <event-name>
```

## StatefulSet Operations
List all StatefulSets in the cluster:
```sh
kubectl get statefulsets
```

Describe a specific StatefulSet:
```sh
kubectl describe statefulset <statefulset-name>
```

Scale a StatefulSet:
```sh
kubectl scale statefulset <statefulset-name> --replicas=<replica-count>
```

## DaemonSet Operations
List all DaemonSets in the cluster:
```sh
kubectl get daemonsets
```

Describe a specific DaemonSet:
```sh
kubectl describe daemonset <daemonset-name>
```
```

Feel free to copy and use this in your GitHub repository! If you need any more adjustments, just let me know. 😊
