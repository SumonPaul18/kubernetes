# Certified Kubernetes Administrator (CKA) - V1.27

## Create a Nginx pod name nginxpod and schedule on controlpanel node

~~~
nano nginxpod.yaml
~~~
~~~
apiVersion: v1
kind: Pod
metadata:
  labels:
  name: nginxpod
    run: nginxpod
spec:
  nodeName: master
  containers:
  - image: nginx
    name: nginxpod
  restartPolicy: Always
~~~
Apply the pod
~~~
kubectl apply -f nginxpod.yaml
~~~
## Expose the existing nginxpod port 80
~~~
kubectl expose pod nginxpod --name=nginxsvc --port=80
~~~

#
### Reference:
#### 1. [freecodecamp.org](https://www.freecodecamp.org/news/certified-kubernetes-administrator-study-guide-cka/)
#### 2. [arkalim.notion.site](https://arkalim.notion.site/Kubernetes-c64b2976b0364cc69864490edef33717)
#### 3. [Assign Pods to Nodes, nodeSelector, Affinity Features](https://medium.com/kubernetes-tutorials/learn-how-to-assign-pods-to-nodes-in-kubernetes-using-nodeselector-and-affinity-features-e62c437f3cf8)
#### 4. [Kubernetes scheduler deep dive](https://dev.to/danielepolencic/kubernetes-scheduler-deep-dive-3phj)
#### 5. [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
#### 6. [Taints and Tolerations, Node Affinity, and Node Selector — Explained](https://medium.com/saas-infra/taints-and-tolerations-node-affinity-and-node-selector-explained-f329653c2bc6)
#### 7. [Taints and Tolerations Usage with Node Selector in Kubernetes Scheduling](https://opstree.com/blog/2021/05/11/taints-and-tolerations-usage-with-node-selector-in-kubernetes-scheduling/)
#### 8. [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
#### 9. [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
#### 10. [Assign Pods to Nodes](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/)
#### 11. [Translate a Docker Compose File to Kubernetes Resources](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/)
#### 12. [How to expose the Kubernetes Application](https://medium.com/weles-ai/how-to-expose-the-kubernetes-application-68cb30ea15c7)
#### 13. [Kubernetes 101: Deploying a web application and database](https://www.endpointdev.com/blog/2022/01/kubernetes-101/)
#### 14. [Taints & Tolerations With Examples](https://blog.kubecost.com/blog/kubernetes-taints/)
#### 15. [Advanced Scheduling in Kubernetes (Youtube)](https://www.youtube.com/watch?v=PeENP0XO0FQ)
#### 16. [Node Selector, Node Affinity, Taints and Tolerations (Youtube)](https://www.youtube.com/watch?v=O61HDmGUBJM)
#### 17. [Node Selector vs Node Affinity vs Pod Affinity vs Tains & Tolerations (Official Docs)](https://www.youtube.com/watch?v=rX4v_L0k4Hc)
#### 18. [Labels,Selectors,ReplicationController and replicaset (Technical Guftgu)](https://www.youtube.com/watch?v=dQSQELeC2A4&list=PL5yTXsHqphjtp26VEnX_4uE5xZT1WCfMo&index=6)
#### 19. [taint and toleration (Gaurav Sharma)](https://www.youtube.com/watch?v=QoeHrVzc21g&list=PL6XT0grm_TfhFKUv_KI_DTVr0TCincl1r&index=55)
#### 20. [What is PV and PVC in Kubernetes](https://www.youtube.com/watch?v=4GtZsY27h40)
#### 21. [REAL CKA Exam Questions](https://www.youtube.com/watch?v=o_7jlMBHFFA)
#### 22. []()
#### 23. []()
