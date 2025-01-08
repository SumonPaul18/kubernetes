# How to Use ConfigMap & Secret on Kubernetes

~~~
rm -rf kubernetes
git clone https://github.com/SumonPaul18/kubernetes.git
cd kubernetes/k8s-example/configMap/configmap-example-1
kubectl apply -f .
kubectl get deploy,pv,pvc,pod
~~~
---
# Details:
এখানে K8s ConfigMap ব্যবহারের একটি বাস্তব উদাহরণ দেওয়া হলো যেখানে একটি নেমস্পেসের মধ্যে MySQL, Nginx, এবং phpMyAdmin ডেপ্লয় করা হয়েছে এবং NFS persistent volume ব্যবহার করা হয়েছে।

### ধাপ ১: Namespace তৈরি করা
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: web-app
```

### ধাপ ২: ConfigMap তৈরি করা
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  namespace: web-app
data:
  database-name: mydatabase
  database-user: user
  database-password: password
  database-root-password: rootpassword
```

### ধাপ ৩: Persistent Volume এবং Persistent Volume Claim তৈরি করা
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteMany
  nfs:
    path: /path/to/nfs
    server: nfs-server.example.com
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
  namespace: web-app
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
```

### ধাপ ৪: MySQL Deployment এবং Service তৈরি করা
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  namespace: web-app
spec:
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        env:
        - name: MYSQL_DATABASE
          valueFrom:
            configMapKeyRef:
              name: mysql-config
              key: database-name
        - name: MYSQL_USER
          valueFrom:
            configMapKeyRef:
              name: mysql-config
              key: database-user
        - name: MYSQL_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: mysql-config
              key: database-password
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: mysql-config
              key: database-root-password
        ports:
        - containerPort: 3306
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: nfs-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: mysql
  namespace: web-app
spec:
  ports:
  - port: 3306
  selector:
    app: mysql
```

### ধাপ ৫: Nginx Deployment এবং Service তৈরি করা
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: web-app
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
  namespace: web-app
spec:
  ports:
  - port: 80
  selector:
    app: nginx
```

### ধাপ ৬: phpMyAdmin Deployment এবং Service তৈরি করা
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: phpmyadmin
  namespace: web-app
spec:
  selector:
    matchLabels:
      app: phpmyadmin
  template:
    metadata:
      labels:
        app: phpmyadmin
    spec:
      containers:
      - name: phpmyadmin
        image: phpmyadmin/phpmyadmin
        env:
        - name: PMA_HOST
          value: mysql
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: phpmyadmin
  namespace: web-app
spec:
  ports:
  - port: 80
  selector:
    app: phpmyadmin
```
---

এখানে কিভাবে আপনি এই YAML ফাইলগুলো রান, চেক এবং ডিলেট করবেন তার ধাপগুলি দেওয়া হলো:

### ১। ফাইলগুলো রান করা
প্রথমে, আপনার YAML ফাইলগুলো একটি ডিরেক্টরিতে সংরক্ষণ করুন। তারপর, নিচের কমান্ডগুলো ব্যবহার করে ফাইলগুলো রান করুন:

```bash
kubectl apply -f configmap-namespace.yaml
kubectl apply -f configmap.yaml
kubectl apply -f configmap-nfs-pv-pvc.yaml
kubectl apply -f mysql-deploy.yaml
kubectl apply -f nginx-deploy.yaml
kubectl apply -f phpmyadmin-deploy.yaml
```

### ২। ডেপ্লয়মেন্ট চেক করা
ডেপ্লয়মেন্ট এবং পডগুলোর স্ট্যাটাস চেক করতে নিচের কমান্ডগুলো ব্যবহার করুন:

```bash
kubectl get namespaces
kubectl get configmaps -n web-app
kubectl get pv
kubectl get pvc -n web-app
kubectl get deployments -n web-app
kubectl get pods -n web-app
kubectl get services -n web-app
```

### ৩। ফাইলগুলো ডিলেট করা
যদি আপনি ডেপ্লয়মেন্ট এবং অন্যান্য রিসোর্সগুলো ডিলেট করতে চান, নিচের কমান্ডগুলো ব্যবহার করুন:

```bash
kubectl delete -f phpmyadmin-deployment.yaml
kubectl delete -f nginx-deployment.yaml
kubectl delete -f mysql-deployment.yaml
kubectl delete -f pvc.yaml
kubectl delete -f pv.yaml
kubectl delete -f configmap.yaml
kubectl delete -f namespace.yaml
```

এই ধাপগুলি অনুসরণ করে আপনি সহজেই আপনার Kubernetes ডেপ্লয়মেন্ট পরিচালনা করতে পারবেন। কোনো প্রশ্ন থাকলে জানাতে পারেন! 😊


এই ধাপগুলি অনুসরণ করে আপনি একটি সম্পূর্ণ Kubernetes ডেপ্লয়মেন্ট তৈরি করতে পারবেন যেখানে MySQL, Nginx, এবং phpMyAdmin ব্যবহার করা হয়েছে এবং persistent storage হিসাবে NFS ব্যবহার করা হয়েছে। কোনো প্রশ্ন থাকলে জানাতে পারেন! 😊

[1](https://kubernetes.io/docs/concepts/storage/volumes/): [Kubernetes Volumes Documentation](https://kubernetes.io/docs/concepts/storage/volumes/)
[2](https://geek-cookbook.funkypenguin.co.nz/kubernetes/persistence/nfs-subdirectory-provider/): [NFS in Kubernetes](https://geek-cookbook.funkypenguin.co.nz/kubernetes/persistence/nfs-subdirectory-provider/)
[3](https://www.itwonderlab.com/kubernetes-nfs/): [Using NFS Persistent Volume in Kubernetes](https://www.itwonderlab.com/kubernetes-nfs/)
