# How to Deploy MySQL on Kubernetes
~~~
rm -rf install-kubeadm
git clone https://github.com/SumonPaul18/install-kubeadm.git
cd install-kubeadm/k8s-example/k8s-mysql
kubectl apply -f mysql-deploy.yaml
kubectl get deploy,pv,pvc,pod
~~~