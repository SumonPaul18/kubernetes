# How to Deploy MySQL on Kubernetes

~~~
rm -rf kubernetes
git clone https://github.com/SumonPaul18/kubernetes.git
cd kubernetes/k8s-example/k8s-mysql
kubectl apply -f mysql-deploy.yaml
kubectl get deploy,pv,pvc,pod
~~~

### Access Your MySQL Instance
~~~
kubectl get pod
~~~
Get a shell for the pod by executing the following command:
~~~
kubectl exec --stdin --tty [pod_name] -- /bin/bash
~~~
Type the following command to access the MySQL shell:
~~~
mysql -p
~~~
Now prompted, enter the password we defined in the Kubernetes secret.

Enter the SQL command to show the database.

~~~
show databases
~~~

#

