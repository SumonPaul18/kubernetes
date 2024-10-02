Sure! Here's the improved list of Kubernetes commands formatted for GitHub Markdown:

```markdown
# Kubernetes Commands

## Cluster Information
- `kubectl cluster-info`: Get cluster information.

## Node Operations
- `kubectl get nodes`: List all the nodes.
- `kubectl describe node <node-name>`: Describe a specific node.
- `kubectl drain <node>`: Drain a node for maintenance.
- `kubectl label nodes <node-name> <label-key>=<label-value>`: Add labels to a node.
- `kubectl cordon <node>`: Mark a node as unschedulable.
- `kubectl uncordon <node>`: Mark a node as schedulable again after it has been drained.
- `kubectl top <node>`: Show metrics for a given node.

## Namespace Operations
- `kubectl describe namespace`: Describe all namespaces.
- `kubectl create namespace <namespace-name>`: Create a specific namespace.
- `kubectl get namespace`: List all namespaces.
- `kubectl get ns`: Shortened version of `kubectl get namespace`.
- `kubectl describe namespace <namespace-name>`: Describe a specific namespace.
- `kubectl config set-context --current --namespace=<namespace-name>`: Switch to a different namespace.
- `kubectl delete namespace <namespace-name>`: Delete a namespace.
- `kubectl edit namespace <namespace-name>`: Edit and update the namespace definition.

## Resource Operations
- `kubectl apply -f <resource-definition.yaml>`: Create or update a resource from a YAML file.
- `kubectl create`: Create an object imperatively.
- `kubectl apply -f https://url-to-resource-definition.yaml`: Create a resource by using the URL.

## Viewing and Finding Resources
- `kubectl get <resource-type>`: List all resources of a specific type.
- `kubectl get <resource-type> -o wide`: List all resources with additional details.
- `kubectl describe <resource-type> <resource-name>`: Describe a specific resource.
- `kubectl get <resource-type> -l <label-key>=<label-value>`: List all resources with a specific label.
- `kubectl get <resource-type> --all-namespaces`: List all resources in all namespaces.
- `kubectl get <resource-type> --sort-by=<field>`: List all resources sorted by a specific field.
- `kubectl get <resource-type> -l <label-selector>`: List resources with a specific label selector.
- `kubectl get <resource-type> --field-selector=<field-selector>`: List resources with a specific field selector.
- `kubectl get <resource-type> -n <namespace>`: List all resources in a specific namespace.

## Deleting Resources
- `kubectl delete <resource-type> <resource-name>`: Delete a resource.
- `kubectl delete <resource-type1> <resource-name1> <resource-type2> <resource-name2>`: Delete multiple resources.
- `kubectl delete <resource-type> --all`: Delete all resources of a specific type.
- `kubectl delete -f <resource-definition.yaml>`: Delete the resource defined in a YAML file.
- `kubectl delete -f https://url-to-resource-definition.yaml`: Delete the resource by using the URL.
- `kubectl delete <resource-type> --all -n <namespace>`: Delete all resources in a specific namespace.

## Pod Operations
- `kubectl get pods`: List all pods in the cluster.
- `kubectl describe pod <pod-name>`: Describe a specific pod.
- `kubectl logs <pod-name>`: View the logs of a specific pod.
- `kubectl exec -it <pod-name> -- <command>`: Execute a command in a specific pod.

## Service Operations
- `kubectl get services`: List all services in the cluster.
- `kubectl describe service <service-name>`: Describe a specific service.

## Deployment Operations
- `kubectl get deployments`: List all deployments in the cluster.
- `kubectl describe deployment <deployment-name>`: Describe a specific deployment.
- `kubectl scale deployment <deployment-name> --replicas=<replica-count>`: Scale a deployment.
- `kubectl rollout history <resource-type> <resource-name>`: View rollout history of a deployment or replicaset.
- `kubectl rollout undo <resource-type> <resource-name>`: Rollback a deployment or replicaset to a previous revision.
- `kubectl rollout status <resource-type> <resource-name>`: View rollout status of a deployment or replicaset.
- `kubectl rollout pause <resource-type> <resource-name>`: Temporarily pause the rollout of a deployment or replicaset.
- `kubectl rollout resume <resource-type> <resource-name>`: Resume a paused rollout of a deployment or replicaset.

## Configuration and Context
- `kubectl config get-contexts`: List all available contexts.
- `kubectl config use-context <context-name>`: Switch to a different context.

## Secret Operations
- `kubectl create secret`: Create a secret imperatively.
- `kubectl get secrets`: List all secrets in the cluster.
- `kubectl describe secret <secret-name>`: Describe a specific secret.

## ConfigMap Operations
- `kubectl create configmap`: Create a ConfigMap imperatively.
- `kubectl get configmaps`: List all ConfigMaps in the cluster.
- `kubectl describe configmap <configmap-name>`: Describe a specific ConfigMap.

## Persistent Volume (PV) and Persistent Volume Claim (PVC) Operations
- `kubectl get pv`: List all Persistent Volumes in the cluster.
- `kubectl describe pv <pv-name>`: Describe a specific Persistent Volume.
- `kubectl get pvc`: List all Persistent Volume Claims in the cluster.
- `kubectl describe pvc <pvc-name>`: Describe a specific Persistent Volume Claim.

## Role-Based Access Control (RBAC) Operations
- `kubectl create role`: Create a role imperatively.
- `kubectl get roles`: List all roles in the cluster.
- `kubectl describe role <role-name>`: Describe a specific role.
- `kubectl create rolebinding`: Create a role binding imperatively.
- `kubectl get rolebindings`: List all role bindings in the cluster.
- `kubectl describe rolebinding <rolebinding-name>`: Describe a specific role binding.

## Ingress Operations
- `kubectl get ingress`: List all ingresses in the cluster.
- `kubectl describe ingress <ingress-name>`: Describe a specific ingress.

## Job and CronJob Operations
- `kubectl get jobs`: List all jobs in the cluster.
- `kubectl describe job <job-name>`: Describe a specific job.
- `kubectl get cronjobs`: List all cron jobs in the cluster.
- `kubectl describe cronjob <cronjob-name>`: Describe a specific cron job.

## Network Policy Operations
- `kubectl get networkpolicies`: List all network policies in the cluster.
- `kubectl describe networkpolicy <networkpolicy-name>`: Describe a specific network policy.

## Namespace Resource Quota Operations
- `kubectl get resourcequotas`: List all resource quotas in a namespace.
- `kubectl describe resourcequota <resourcequota-name>`: Describe a specific resource quota in a namespace.

## Horizontal Pod Autoscaler (HPA) Operations
- `kubectl get hpa`: List all horizontal pod autoscalers in the cluster.
- `kubectl describe hpa <hpa-name>`: Describe a specific horizontal pod autoscaler.

## Event Operations
- `kubectl get events`: List all events in the cluster.
- `kubectl describe event <event-name>`: Describe a specific event.

## StatefulSet Operations
- `kubectl get statefulsets`: List all StatefulSets in the cluster.
- `kubectl describe statefulset <statefulset-name>`: Describe a specific StatefulSet.
- `kubectl scale statefulset <statefulset-name> --replicas=<replica-count>`: Scale a StatefulSet.

## DaemonSet Operations
- `kubectl get daemonsets`: List all DaemonSets in the cluster.
- `kubectl describe daemonset <daemonset-name>`: Describe a specific DaemonSet.
```

Feel free to copy and paste this into your GitHub repository! If you need any more help, just let me know. 😊
