# How to Deploy Nginx on Kubernetes

~~~
rm -rf install-kubeadm
git clone https://github.com/SumonPaul18/install-kubeadm.git
cd install-kubeadm/k8s-example/k8s-nginx
kubectl apply -f nginx-deploy-nfs-svc.yaml
kubectl get deploy,pv,pvc,pod,svc
~~~

### Access The Nginx Instance
~~~
kubectl get pod
~~~
#### Delete all to Nginx-Deploy
~~~
kubectl delete deploy nginx-deployment 
kubectl delete pvc nginx-nfs-pvc
kubectl delete pv nginx-nfs-pv
kubectl delete svc nginx-svc
~~~
#
