#### Verifying How Many Nodes are in K8s Claster
~~~
kubectl get node
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
#### We will see that the nginx pod runing on default node.
~~~
nano nginx.yaml
~~~
#### Adding nodeName Attribute in nginx.yaml
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
kubectl delete pod nginx
~~~
~~~
kubectl apply -f nginx.yaml
~~~
~~~
kubectl get pod -o wide
~~~
~~~
kubectl get nodes
~~~
~~~
kubectl get nodes |awk '{print $1}'
~~~
~~~
kubectl get nodes --no-headres |awk '{print $1}'
~~~
~~~
kubectl describe nodes | grep -i taint
~~~
~~~
kubectl taint node worker dc-location=dhaka:NoSchedule
~~~
~~~
kubectl describe nodes | grep -i taint
~~~
~~~
kubectl run my-app-dhaka --image=nginx -o yaml --dry-run=client > my-app-dhaka.yaml
~~~
~~~
nano my-app-dhaka.yaml
~~~
~~~
kubectl apply -f my-app-dhaka.yaml
~~~
~~~
nano my-app-dhaka.yaml
~~~
~~~
kubectl apply -f my-app-dhaka.yaml
~~~
~~~
kubectl get pod -o wide
~~~
~~~
kubectl delete pod my-app-dhaka
~~~
~~~
nano my-app-dhaka.yaml
~~~
~~~
kubectl label nodes worker size=large
~~~
~~~
nano my-app-dhaka.yaml
~~~
~~~
kubectl apply my-app-dhaka.yaml
~~~
~~~
kubectl apply -f my-app-dhaka.yaml
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
kubectl get pod -o wide
~~~
~~~
kubectl delete pod my-app-dhaka
~~~
~~~
kubectl delete pod nginx
~~~
~~~
kubectl get pod
~~~


