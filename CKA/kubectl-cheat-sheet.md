# Kubectl Cheat Sheet

## Cluster Information
Get cluster information:
- `kubectl cluster-info`

## Node Operations
List all the nodes:
- `kubectl get nodes`

Describe a specific node:
- `kubectl describe node <node-name>`

Drain a node for maintenance:
- `kubectl drain <node>`

Add labels to a node:
- `kubectl label nodes <node-name> <label-key>=<label-value>`

Mark a node as unschedulable:
- `kubectl cordon <node>`

Mark a node as schedulable again after it has been drained:
- `kubectl uncordon <node>`

Show metrics for a given node:
- `kubectl top <node>`

## Namespace Operations
Describe all namespaces:
- `kubectl describe namespace`

Create a specific namespace:
- `kubectl create namespace <namespace-name>`

List all namespaces:
- `kubectl get namespace`

Shortened version of `kubectl get namespace`:
- `kubectl get ns`

Describe a specific namespace:
- `kubectl describe namespace <namespace-name>`

Switch to a different namespace:
- `kubectl config set-context --current --namespace=<namespace-name>`

Delete a namespace:
- `kubectl delete namespace <namespace-name>`

Edit and update the namespace definition:
- `kubectl edit namespace <namespace-name>`

## Resource Operations
Create or update a resource from a YAML file:
- `kubectl apply -f <resource-definition.yaml>`

Create an object imperatively:
- `kubectl create`

Create a resource by using the URL:
- `kubectl apply -f https://url-to-resource-definition.yaml`

## Viewing and Finding Resources
List all resources of a specific type:
- `kubectl get <resource-type>`

List all resources with additional details:
- `kubectl get <resource-type> -o wide`

Describe a specific resource:
- `kubectl describe <resource-type> <resource-name>`

List all resources with a specific label:
- `kubectl get <resource-type> -l <label-key>=<label-value>`

List all resources in all namespaces:
- `kubectl get <resource-type> --all-namespaces`

List all resources sorted by a specific field:
- `kubectl get <resource-type> --sort-by=<field>`

List resources with a specific label selector:
- `kubectl get <resource-type> -l <label-selector>`

List resources with a specific field selector:
- `kubectl get <resource-type> --field-selector=<field-selector>`

List all resources in a specific namespace:
- `kubectl get <resource-type> -n <namespace>`

## Deleting Resources
Delete a resource:
- `kubectl delete <resource-type> <resource-name>`

Delete multiple resources:
- `kubectl delete <resource-type1> <resource-name1> <resource-type2> <resource-name2>`

Delete all resources of a specific type:
- `kubectl delete <resource-type> --all`

Delete the resource defined in a YAML file:
- `kubectl delete -f <resource-definition.yaml>`

Delete the resource by using the URL:
- `kubectl delete -f https://url-to-resource-definition.yaml`

Delete all resources in a specific namespace:
- `kubectl delete <resource-type> --all -n <namespace>`

## Pod Operations
List all pods in the cluster:
- `kubectl get pods`

Describe a specific pod:
- `kubectl describe pod <pod-name>`

View the logs of a specific pod:
- `kubectl logs <pod-name>`

Execute a command in a specific pod:
- `kubectl exec -it <pod-name> -- <command>`

## Service Operations
List all services in the cluster:
- `kubectl get services`

Describe a specific service:
- `kubectl describe service <service-name>`

## Deployment Operations
List all deployments in the cluster:
- `kubectl get deployments`

Describe a specific deployment:
- `kubectl describe deployment <deployment-name>`

Scale a deployment:
- `kubectl scale deployment <deployment-name> --replicas=<replica-count>`

View rollout history of a deployment or replicaset:
- `kubectl rollout history <resource-type> <resource-name>`

Rollback a deployment or replicaset to a previous revision:
- `kubectl rollout undo <resource-type> <resource-name>`

View rollout status of a deployment or replicaset:
- `kubectl rollout status <resource-type> <resource-name>`

Temporarily pause the rollout of a deployment or replicaset:
- `kubectl rollout pause <resource-type> <resource-name>`

Resume a paused rollout of a deployment or replicaset:
- `kubectl rollout resume <resource-type> <resource-name>`

## Configuration and Context
List all available contexts:
- `kubectl config get-contexts`

Switch to a different context:
- `kubectl config use-context <context-name>`

## Secret Operations
Create a secret imperatively:
- `kubectl create secret`

List all secrets in the cluster:
- `kubectl get secrets`

Describe a specific secret:
- `kubectl describe secret <secret-name>`

## ConfigMap Operations
Create a ConfigMap imperatively:
- `kubectl create configmap`

List all ConfigMaps in the cluster:
- `kubectl get configmaps`

Describe a specific ConfigMap:
- `kubectl describe configmap <configmap-name>`

## Persistent Volume (PV) and Persistent Volume Claim (PVC) Operations
List all Persistent Volumes in the cluster:
- `kubectl get pv`

Describe a specific Persistent Volume:
- `kubectl describe pv <pv-name>`

List all Persistent Volume Claims in the cluster:
- `kubectl get pvc`

Describe a specific Persistent Volume Claim:
- `kubectl describe pvc <pvc-name>`

## Role-Based Access Control (RBAC) Operations
Create a role imperatively:
- `kubectl create role`

List all roles in the cluster:
- `kubectl get roles`

Describe a specific role:
- `kubectl describe role <role-name>`

Create a role binding imperatively:
- `kubectl create rolebinding`

List all role bindings in the cluster:
- `kubectl get rolebindings`

Describe a specific role binding:
- `kubectl describe rolebinding <rolebinding-name>`

## Ingress Operations
List all ingresses in the cluster:
- `kubectl get ingress`

Describe a specific ingress:
- `kubectl describe ingress <ingress-name>`

## Job and CronJob Operations
List all jobs in the cluster:
- `kubectl get jobs`

Describe a specific job:
- `kubectl describe job <job-name>`

List all cron jobs in the cluster:
- `kubectl get cronjobs`

Describe a specific cron job:
- `kubectl describe cronjob <cronjob-name>`

## Network Policy Operations
List all network policies in the cluster:
- `kubectl get networkpolicies`

Describe a specific network policy:
- `kubectl describe networkpolicy <networkpolicy-name>`

## Namespace Resource Quota Operations
List all resource quotas in a namespace:
- `kubectl get resourcequotas`

Describe a specific resource quota in a namespace:
- `kubectl describe resourcequota <resourcequota-name>`

## Horizontal Pod Autoscaler (HPA) Operations
List all horizontal pod autoscalers in the cluster:
- `kubectl get hpa`

Describe a specific horizontal pod autoscaler:
- `kubectl describe hpa <hpa-name>`

## Event Operations
List all events in the cluster:
- `kubectl get events`

Describe a specific event:
- `kubectl describe event <event-name>`

## StatefulSet Operations
List all StatefulSets in the cluster:
- `kubectl get statefulsets`

Describe a specific StatefulSet:
- `kubectl describe statefulset <statefulset-name>`

Scale a StatefulSet:
- `kubectl scale statefulset <statefulset-name> --replicas=<replica-count>`

## DaemonSet Operations
List all DaemonSets in the cluster:
- `kubectl get daemonsets`

Describe a specific DaemonSet:
- `kubectl describe daemonset <daemonset-name>`

Feel free to copy and use this in your GitHub repository! If you need any more adjustments, just let me know. 😊
