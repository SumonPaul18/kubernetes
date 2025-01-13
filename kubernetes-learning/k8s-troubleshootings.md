### 𝐊𝐮𝐛𝐞𝐫𝐧𝐞𝐭𝐞𝐬 𝐓𝐫𝐨𝐮𝐛𝐥𝐞𝐬𝐡𝐨𝐨𝐭𝐢𝐧𝐠 𝐂𝐨𝐦𝐦𝐚𝐧𝐝𝐬 𝐄𝐯𝐞𝐫𝐲 𝐃𝐞𝐯𝐎𝐩𝐬 𝐄𝐧𝐠𝐢𝐧𝐞𝐞𝐫 𝐌𝐮𝐬𝐭 𝐊𝐧𝐨𝐰
As a DevOps Engineer, efficient Kubernetes troubleshooting is a key skill that helps ensure applications run smoothly in production. Here’s a list of must-know commands for troubleshooting Kubernetes clusters:

𝟏. 𝐂𝐡𝐞𝐜𝐤 𝐍𝐨𝐝𝐞 𝐒𝐭𝐚𝐭𝐮𝐬
```
kubectl get nodes
```
```
kubectl describe node <node-name>
```
Use these commands to verify node health, resource utilization, and events.

𝟐. 𝐈𝐧𝐬𝐩𝐞𝐜𝐭 𝐏𝐨𝐝𝐬
```
kubectl get pods -o wide
```
```
kubectl describe pod <pod-name>
```
These commands provide pod details, including events and conditions.

𝟑. 𝐃𝐞𝐛𝐮𝐠 𝐏𝐨𝐝 𝐋𝐨𝐠𝐬
```
kubectl logs <pod-name>
```
```
kubectl logs <pod-name> — previous
```
Check logs to understand application behavior or debug container issues.

𝟒. 𝐄𝐱𝐞𝐜 𝐈𝐧𝐭𝐨 𝐚 𝐏𝐨𝐝
```
kubectl exec -it <pod-name> — /bin/bash
```
Gain access to a pod’s container to investigate runtime issues.

𝟓. 𝐂𝐡𝐞𝐜𝐤 𝐑𝐞𝐬𝐨𝐮𝐫𝐜𝐞 𝐔𝐬𝐚𝐠𝐞
```
kubectl top nodes
```
```
kubectl top pods
```
Monitor resource consumption (CPU/Memory) at the node and pod level.

𝟔. 𝐃𝐞𝐛𝐮𝐠 𝐒𝐞𝐫𝐯𝐢𝐜𝐞𝐬 𝐚𝐧𝐝 𝐄𝐧𝐝𝐩𝐨𝐢𝐧𝐭𝐬
```
kubectl get svc
```
```
kubectl describe svc <service-name>
```
```
kubectl get endpoints
```
Ensure the service is exposing the correct pods and endpoints.

𝟕. 𝐈𝐧𝐬𝐩𝐞𝐜𝐭 𝐂𝐨𝐧𝐟𝐢𝐠𝐌𝐚𝐩𝐬 𝐚𝐧𝐝 𝐒𝐞𝐜𝐫𝐞𝐭𝐬
```
kubectl get configmaps
```
```
kubectl get secrets
```
```
kubectl describe configmap <configmap-name>
```
```
kubectl describe secret <secret-name>
```
Validate configuration and sensitive data stored in your cluster.

𝟖. 𝐓𝐫𝐨𝐮𝐛𝐥𝐞𝐬𝐡𝐨𝐨𝐭 𝐃𝐞𝐩𝐥𝐨𝐲𝐦𝐞𝐧𝐭𝐬
```
kubectl get deployments
```
```
kubectl describe deployment <deployment-name>
```
```
kubectl rollout status deployment <deployment-name>
```
```
kubectl rollout undo deployment <deployment-name>
```
Manage deployment issues, such as failed rollouts or improper scaling.

𝟗. 𝐃𝐢𝐚𝐠𝐧𝐨𝐬𝐞 𝐄𝐯𝐞𝐧𝐭𝐬
```
kubectl get events — sort-by=’.metadata.creationTimestamp’
```
Analyze cluster-level events for error patterns and recent issues.

𝟏𝟎. 𝐈𝐧𝐬𝐩𝐞𝐜𝐭 𝐍𝐞𝐭𝐰𝐨𝐫𝐤 𝐏𝐨𝐥𝐢𝐜𝐢𝐞𝐬
```
kubectl get networkpolicy
```
```
kubectl describe networkpolicy <policy-name>
```
Ensure the correct network rules are applied to your pods.

𝟏𝟏. 𝐂𝐡𝐞𝐜𝐤 𝐏𝐞𝐫𝐬𝐢𝐬𝐭𝐞𝐧𝐭 𝐕𝐨𝐥𝐮𝐦𝐞𝐬 𝐚𝐧𝐝 𝐂𝐥𝐚𝐢𝐦𝐬
```
kubectl get pv
```
```
kubectl get pvc
```
```
kubectl describe pvc <pvc-name>
```
Debug storage-related issues impacting your application.

𝟏𝟐. 𝐃𝐞𝐛𝐮𝐠 𝐊𝐮𝐛𝐞𝐫𝐧𝐞𝐭𝐞𝐬 𝐀𝐏𝐈 𝐒𝐞𝐫𝐯𝐞𝐫
```
kubectl cluster-info
```
```
kubectl get componentstatuses
```
