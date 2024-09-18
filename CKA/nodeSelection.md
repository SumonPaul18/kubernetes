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
kubectl get pod -o wide
~~~
kubectl get node
nano nginx.yaml
kubectl delete pod nginx
kubectl apply -f nginx.yaml
kubectl get pod -o wide
kubectl get nodes
kubectl get nodes |awk '{print $1}'
kubectl get nodes --no-headres |awk '{print $1}'
kubectl get nodes --no-headers |awk '{print $1}'
kubectl get nodes --no-headers |awk '{print $1}' > /opt/node_name.txt
cat /opt/node_name.txt
kubectl describe nodes | grep -i taint
kubectl taint node worker dc-location=dhaka:NoSchedule
kubectl describe nodes | grep -i taint
kubectl run my-app-dhaka --image=nginx -o yaml --dry-run=client > my-app-dhaka.yaml
ls
nano my-app-dhaka.yaml
kubectl apply -f my-app-dhaka.yaml
nano my-app-dhaka.yaml
kubectl apply -f my-app-dhaka.yaml
kubectl get pod -o wide
kubectl delete pod my-app-dhaka
nano my-app-dhaka.yaml
kubectl label nodes worker size=large
nano my-app-dhaka.yaml
kubectl apply my-app-dhaka.yaml
kubectl apply -f my-app-dhaka.yaml
kubectl get pod -o wide
kubectl describe nodes worker
kubectl describe nodes master
kubectl get pod -o wide
kubectl delete pod my-app-dhaka
kubectl delete pod nginx
kubectl get pod


