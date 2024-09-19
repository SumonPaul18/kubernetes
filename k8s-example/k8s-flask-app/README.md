# How to Deploy Flask Application on Kubernetes

~~~
rm -rf install-kubeadm
git clone https://github.com/SumonPaul18/install-kubeadm.git
cd install-kubeadm/k8s-example/k8s-flask-app
kubectl apply -f flask.yaml
kubectl get pod,deploy,pv,pvc,svc
~~~

### Verifying the Flask Deploy
~~~
kubectl get pod
~~~
#### Delete the Flask Deploy
~~~
kubectl delete deploy test-flask-app
~~~
#### Delete the Flask Deploy Svc
~~~
kubectl delete svc test-flask-svc
~~~
#### 

#

