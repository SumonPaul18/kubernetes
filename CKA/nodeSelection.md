# Using NodeSelector, Taint & Tolerations, NodeAffinity on K8s Example
#### Verifying How Many Nodes are in K8s Claster
~~~
kubectl get node
~~~
~~~
kubectl get nodes |awk '{print $1}'
~~~
~~~
kubectl get nodes --no-headres |awk '{print $1}'
~~~
#### Generate nginx pod yaml file
~~~
kubectl run nginx --image=nginx -o yaml --dry-run=client > nginx.yaml
~~~
~~~
ls
~~~
~~~
nano nginx.yaml
~~~
~~~
kubectl apply -f nginx.yaml
~~~
~~~
kubectl get pod -o wide
~~~
We will see that the nginx pod runing on default Node.
~~~
kubectl delete pod nginx
~~~
#
#### Now, We will try run pod on seleceted Node
#### Adding nodeName Attribute in nginx.yaml
~~~
nano nginx.yaml
~~~
Here, we can Specefied where run the pods. 
~~~
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
  nodeName: worker
~~~
~~~
kubectl apply -f nginx.yaml
~~~
~~~
kubectl get pod -o wide
~~~
We will see that the nginx pod runing on selected Node.
#
#### Using Taint & Tolerence on Nodes & Pods
#### Verifying Taint on Nodes
~~~
kubectl describe nodes | grep -i taint
~~~
#### Add a Taint to Selected Node using kubectl taint
kubectl taint nodes <node name> <taint key>=<taint value>:<taint effect>
~~~
kubectl taint node worker dc-location=dhaka:NoSchedule
~~~
~~~
kubectl describe node worker | grep -i taint
~~~
~~~
kubectl run tolerations-pod --image=nginx -o yaml --dry-run=client > tolerations-pod.yaml
~~~
~~~
nano tolerations-pod.yaml
~~~
~~~
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: tolerations-pod
  name: tolerations-pod
spec:
  containers:
  - image: nginx
    name: tolerations-pod
  tolerations:
  - key: dc-location
    value: dhaka
    effect: NoSchedule
~~~
~~~
kubectl apply -f tolerations-pod.yaml
~~~
~~~
kubectl get pod -o wide
~~~
We will see that the nginx pod runing on selected Node.
~~~
kubectl delete pod tolerations-pod.yaml
~~~
#### Remove the previously added taint to the worker node.
We can remove the taint by specifying the taint key and the taint effect with a minus(-) to signify the removal. The basic syntax of the command is:

kubectl taint nodes <node name> <taint key>:<taint effect>-

kubectl taint nodes node1 key1=value1:NoSchedule-
~~~
kubectl taint node worker dc-location:NoSchedule-
~~~
#
#### Using Affinity on Nodes & Pods
#### Verifying Labels on Nodes
~~~
kubectl describe node worker
~~~
#### Set a Affinity on Selected Node
~~~
kubectl label nodes worker size=large
~~~
~~~
kubectl run affinity-pod --image=nginx -o yaml --dry-run=client > affinity-pod.yaml
~~~
~~~
nano affinity-pod.yaml
~~~
~~~
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: affinity-pod
  name: affinity-pod
spec:
  containers:
  - image: nginx
    name: affinity-pod
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In
            values:
            - large
~~~
~~~
kubectl apply -f affinity-pod.yaml
~~~
~~~
kubectl get pod -o wide
~~~
~~~
kubectl delete pod affinity-pod.yaml
~~~
#
#### Using tolerations & Affinity on Nodes & Pods
#### Verifying Taint & Labels on Nodes
~~~
kubectl describe nodes | grep -i taint
~~~
~~~
kubectl describe node worker
~~~
~~~
kubectl run tolerations-affinity-pod --image=nginx -o yaml --dry-run=client > tolerations-affinity-pod.yaml
~~~
~~~
nano tolerations-affinity-pod.yaml
~~~
~~~
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: my-app-dhaka
  name: my-app-dhaka
spec:
  containers:
  - image: nginx
    name: my-app-dhaka
  tolerations:
  - key: dc-location
    value: dhaka
    effect: NoSchedule
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In
            values:
            - large
~~~
~~~
kubectl apply tolerations-affinity-pod.yaml
~~~
~~~
kubectl get pod -o wide
~~~
~~~
kubectl describe nodes worker
~~~
~~~
kubectl describe nodes master
~~~
~~~
kubectl delete pod tolerations-affinity-pod.yaml
~~~



