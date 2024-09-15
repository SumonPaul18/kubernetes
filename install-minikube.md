# Install Minikube Kubernetes on Ubuntu

## Installation Steps

#### Step 1. Update Your System
~~~
apt update & sudo apt upgrade -y
~~~
Reboot the system
~~~
reboot
~~~
#### Step 2. Installing Docker
#### Use the following command to adding latest docker binary filies
~~~
apt install ca-certificates curl gnupg wget apt-transport-https -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
~~~
#### Install docker by running the following command.
~~~
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
~~~
#### Add your local user to docker group
~~~
sudo usermod -aG docker $USER
newgrp docker
~~~
#### Step 3. Installing Minikube
#### Use the following curl command to download latest minikube binary filies
~~~
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
~~~
#### Once the binary is downloaded, use the following command to install Minikube
~~~
install minikube-linux-amd64 /usr/local/bin/minikube
~~~
#### Verifying Minikube installation
~~~
minikube version
~~~
#### Output As Like bellow:
> minikube version: v1.32.0
> commit: 8220a6eb95f0a4d75f7f2d7b14cef975f050512d

#### Verify kubectl Version:
~~~
kubectl version --client
~~~

#### Step 4. Installing kubectl utility
~~~
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/
~~~
#### Verify the kubectl version
~~~
kubectl version
~~~
#### Step 5. Starting Minikube
#### When you start minikube 1st time then declear your required driver its could be docker, containerd, virtualbox etc. 
~~~
minikube start –driver=docker
~~~
#### In case Minikube cannot start because there is error regarding the Docker driver. Possible error:
~~~
minikube start --driver=docker --force
~~~
#### Step 6. Verifying Installation
#### Use the following command to verify Minikube:
~~~
minikube status
~~~
#### Output As like As

> minikube
> type: Control Plane
> host: Running
> kubelet: Running
> apiserver: Running
> kubeconfig: Configured

#### Use the following command to verify Kubernetes:
~~~
kubectl cluster-info
~~~
#Output like as:

> Kubernetes control plane is running at https://192.168.49.2:8443
> CoreDNS is running at https://192.168.49.2:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

#

#
## Manage Minikube kubernetes

#Managing Minikube Cluster
#To stop and start the minikube cluster

minikube stop

minikube start

minikube start --force

#In order to delete the minikube cluster

minikube delete

#delete the Service

kubectl delete services my-service

#Continuously watching kubernetes all services

watch kubectl get all -o wide

#List of Kubernetes Nodes:

kubectl get nodes

#Output as like as 

NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   25h   v1.28.3

#View cluster events
kubectl get events

#View the kubectl configuration
kubectl config view

+++++++++++++++++++++++++++++++++
+ Managing Addons on minikube   +
+++++++++++++++++++++++++++++++++

minikube addons list

#If you wish to enable any addons run the below minikube command,

minikube addons enable <addon-name>

#Enable Dashboard Addons

minikube addons enable dashboard

minikube addons enable ingress

++++++++++++++++++++++++++++++++++++

++++++++++++++++++++++++++++++++++++++++++++
+ Accessing Kubernetes Dashboard           +
++++++++++++++++++++++++++++++++++++++++++++

#Installing the Kubernetes Dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml 

#Start kubernetes dashboard using Minikube

minikube dashboard

#List of Namespaces

kubectl get services --all-namespaces

#Check all the resources

kubectl get all -n kubernetes-dashboard

#Accessing the Kubernetes Dashboard from Outside

#Easy Ways
#Port Forwarding for kubernetes-dashboard

kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 10443:443 --address 0.0.0.0

#https://192.168.0.89:10443

#Another Ways

##We will have to change the type of service from ClusterIp to NodePort. So, give the following command to edit the service and make the following changes.

kubectl edit service/kubernetes-dashboard -n kubernetes-dashboard

#After: You can give the IP of your wish if 32321 is occupied
#Now, check if the service was changed successfully by giving the following command:

kubectl get svc

#It will open the Kubernetes dashboard in the web browser.

#kubectl proxy --address='0.0.0.0' --disable-filter=true
#kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'
#kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='^*$'

kubectl -n kubernetes-dashboard describe service kubernetes-dashboard

+++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++
+ Kubernetes Error & Solutions      +
+++++++++++++++++++++++++++++++++++++

kubectl config get-contexts

#Error 01:
@"kubeconfig: Misconfigured" error 

Here's a summary of the commands you can try:
minikube status
minikube start
ls -l ~/.kube/config
chmod 600 ~/.kube/config
minikube kubectl

#Error 02:

#Error from server (BadRequest): container "jenkins" in pod "jenkins-7c4946cc58-mcngv" is waiting to start: ContainerCreating

#Troubleshoot
kubectl get events --sort-by=.metadata.creationTimestamp

++++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++
+ Deploy a sample nginx deployment  +
+++++++++++++++++++++++++++++++++++++

kubectl create deployment nginx-web --image=nginx

kubectl expose deployment nginx-web --type NodePort --port=80

kubectl get deployment,pod,svc

+++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++++++++++++++++
+ Create Pod Nginx web server using YML           + 
+++++++++++++++++++++++++++++++++++++++++++++++++++

nano nginx.yml

apiVersion: v1 
kind: Pod 
metadata:
  name: nginx-pod 
spec:
  containers:
  - name: nginx 
    image: nginx:latest 
    ports:
    - containerPort: 80 


kubectl apply -f nginx.yml

+++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++
+ Kubectl Port-Forwarding Syntax    +
+++++++++++++++++++++++++++++++++++++

#Port-Forward Syntax

kubectl port-forward POD_NAME LOCAL_PORT:REMOTE_POD_PORT

#Command Description 
POD_NAME: Give our pod name.
LOCAL_PORT: Give a port which we access from the internet.
REMOTE_POD_PORT: Give our pods default port.

#Example:
kubectl port-forward nginx-pod 8085:80 --address 0.0.0.0

#Kubectl port-forward in background

kubectl port-forward nginx-pod 8085:80 &

kubectl port-forward nginx-pod 8085:80 --address 0.0.0.0 &

#Port-Forwarding a local port to a pod with address binding:
#kubectl port-forward --address <address> <pod-name> <local-port>:<pod-port>
Example command:

kubectl port-forward --address 192.168.0.100 my-pod 8080:80

# Forwarding a local port to a service with address binding:
#kubectl port-forward --address <address> service/<service-name> <local-port>:<service-port>
Example command:

kubectl port-forward --address 192.168.0.100 service/my-service 8080:80

#Listen on a random port locally, forwarding to 80 in the pod

kubectl port-forward pod/nginx :80

#Check port-forwarding services 

ps -ef | grep port-forward

#Analyze Network Connections

netstat -antp

+++++++++++++++++++++++++++++++++++++++

++++++++++++++++++++++++++++++++++++++++++++
+ Kubectl Basic Operation in Kubernetes    +
++++++++++++++++++++++++++++++++++++++++++++

#Run a Pod
kubectl run nginx -–image nginx

#Port-forwarding the pod
kubectl port-forward nginx 8080:80

#View the Pod Logs
kubectl logs nginx

#View the Pod Logs Continuously
kubectl logs -f pod-name

#Run a Pod with Shell Exection  
kubectl run myshell -it –image busybox –sh

#Run a Pod with Shell Exection and auto delete pods
kubectl run myshell —rm –it –image busybox –sh

#Create a Deployment
kubectl create deployment nginx --image nginx:latest --replicas 3

#List of Deployments
kubectl get deployment

#Scale a Deployment
kubectl scale deployment nginx --replicas 5

#Delete Deployment
kubectl delete deploy myshell

#Create a pod using local docker images using image-policy
kubectl run myportfolio --image=myportfolio:latest --image-pull-policy=Never --restart=Never

#Delete Pods
kubectl delete pod myportfolio

#Delete all Pods
kubectl delete pods –all

#Delete pods & services using label name
kubectl delete pods,services -l name=label-name

#View Description
kubectl describe pod nginx 

#Expose a Service
kubectl expose deployment nginx –type NodePort –port 80

#View Service Description
kubectl describe svc ngnix

#List of pods widely
kubectl get pods -o wide

#Execute command from outside to the inside pods
kubectl exec pod-name date

#Execute command from outside to the inside pods
kubectl exec pod-name -c container-name date

#Execute pods
kubectl exec -it pod-name /bin/bash

#Create a Namespace
kubectl create namespace devops-tool-suite

+++++++++++++++++++++++++++++++++++++++++++++
Kubernetes Persistent Volumes using HostPath
+++++++++++++++++++++++++++++++++++++++++++++

#Check your cluster’s storage classes

kubectl get storageclass

#Create a Persistent Volume

apiVersion: v1
kind: PersistentVolume
metadata:
  name: nginxpv
spec:
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 1Gi
  storageClassName: standard
  hostPath:
    path: /nfsstorage/nginxdata
    
---
#Create a Persistent Volume Claim

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nginxpvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
  volumeName: nginxpv
  
---
#Attach PVCs to Pods

apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
      volumeMounts:
          name: data
        - mountPath: /usr/share/nginx/html
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: nginxpvc
        
+++++++++++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++++++++++
Kubernetes Persistent Volumes using NFS
+++++++++++++++++++++++++++++++++++++++++++++

apiVersion: v1
kind: PersistentVolume
metadata:
  name: mynfspv
spec:
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
  nfs:
    server: 192.168.0.89
    path: /nfsstorage/jenkins_home
  persistentVolumeReclaimPolicy: Retain

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mynfspvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
---
#Attach PVCs to Pods

apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
      volumeMounts:
          name: data
        - mountPath: /usr/share/nginx/html
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: mynfspvc
        

+++++++++++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++++++++++
Jenkins Deployment in Kubernetes
+++++++++++++++++++++++++++++++++++++++++++++

apiVersion: apps/v1
kind: Deployment
metadata:
  name: myjenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myjenkins
  template:
    metadata:
      labels:
        app: myjenkins
    spec:
      containers:
      - name: myjenkins
        image: jenkins/jenkins:lts
        ports:
          - name: http-port
            containerPort: 8080
          - name: jnlp-port
            containerPort: 50000
        #command: ["sh", "-c", "chown -R 777:777 /var/jenkins_home"]
        #command: ["sh", "-c", "chown root:root /var/jenkins_home"]
        volumeMounts:
          - name: jenkins-home
            mountPath: /var/jenkins_home
      volumes:
          - name: jenkins-home
            persistentVolumeClaim:
             claimName: pvcnfs

+++++++++++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++++++++++
Manage Kubernetes Storage 
+++++++++++++++++++++++++++++++++++++++++++++

kubectl get sc

kubectl get pv

kubectl get pvc

kubectl describe sc sc-name

kubectl describe pv pv-name

kubectl describe pvc pvc-name

kubectl delete sc sc-name

kubectl delete pvc pvc-name

kubectl delete pv pv-name

+++++++++++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++++++++++
Run Nginx Pod using NFS Data Persistent 
+++++++++++++++++++++++++++++++++++++++++++++

apiVersion: v1 
kind: Pod 
metadata:
  name: web1 
spec:
  containers:
  - name: nginx 
    image: nginx:latest 
    ports:
    - containerPort: 80 
    volumeMounts:
      - mountPath: /usr/share/nginx/html
        name: nginxstorage
  volumes:
    - name: nginxstorage
      nfs:
        server: 192.168.0.89
        path: /nfsstorage

+++++++++++++++++++++++++++++++++++++++++++++

# Create yml file using image-pull-policy=Never

apiVersion: v1
kind: Pod
metadata:
  name: web1
spec:
  containers:
  - name: myportfolio
    image: myportfolio:latest
    imagePullPolicy: Never
    ports:
    - containerPort: 80
    volumeMounts:
      - mountPath: /usr/share/nginx/html
        name: nginxstorage
  volumes:
    - name: nginxstorage
      nfs:
        server: 192.168.0.89
        path: /nfsstorage/myportfolio
        

+++++++++++++++++++++++++++++++++++++++++++++


