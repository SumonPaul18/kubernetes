## ConfigMap ব্যবহার করে একটি সাধারণ ওয়েব অ্যাপ্লিকেশন এবং একটি ডাটাবেস (MySQL) Kubernetes এ ডিপ্লয় করার প্রক্রিয়া ধাপে ধাপে  নিচে দেওয়া হল।

### ধাপ ১: ConfigMap তৈরি করা

এখন, অ্যাপ্লিকেশনের জন্য প্রয়োজনীয় কনফিগারেশন ডেটা সংরক্ষণ করতে একটি ConfigMap তৈরি করুন।

#### ConfigMap YAML ফাইল (`app-configmap.yaml`)

```
nano app-configmap.yaml
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-configmap
data:
  MYSQL_ROOT_PASSWORD: "configmap"
  MYSQL_DATABASE: "configmap-db"
  MYSQL_USER: "admin"
  MYSQL_PASSWORD: "configmap"
  PMA_HOST: "mysql"
  PMA_PORT: "3306"
```
### ধাপ ২: MySQL ডাটাবেস ডিপ্লয় করা

MySQL ডাটাবেসের জন্য একটি ডিপ্লয়মেন্ট এবং সার্ভিস তৈরি করুন।

#### MySQL Deployment YAML ফাইল (`mysql-deployment.yaml`)

```
nano mysql-deployment.yaml
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: mysql:5.7
        name: mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_PASSWORD
        ports:
        - containerPort: 3306
          name: mysql
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: configmap-pvc-claim
```
### ধাপ ৩: MySQL এর জন্য সার্ভিস তৈরি করা 
#### MySQL Service YAML ফাইল (`mysql-service.yaml`)

```
nano mysql-service.yaml
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  ports:
  - port: 3306
  selector:
    app: mysql
```
### ধাপ ৪: MySQL এর জন্য Persistent Volume তৈরি করা
### আমি এখানে PV হিসাবে NFS Storage ব্যবহার করেছি। 
#### Persistent Volume এবং Persistent Volume Claim YAML ফাইল (`mysql-pv-pvc.yaml`)

```
nano mysql-pv-pvc.yaml
```

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: configmap-nfs-pv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: nfs
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /nfs-share/configmap/mysql
    server: 192.168.0.96
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: configmap-pvc-claim
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```

### ধাপ ৫: ওয়েব অ্যাপ্লিকেশন ডিপ্লয় করা

এখন, ওয়েব অ্যাপ্লিকেশন ডিপ্লয় করুন যা ConfigMap থেকে কনফিগারেশন ডেটা ব্যবহার করবে।

#### Web Application Deployment YAML ফাইল (`webapp-deployment.yaml`)

```
nano webapp-deployment.yaml
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: webapp
        image: nginx
        env:
        - name: DATABASE_URL
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: PMA_HOST
        - name: DATABASE_NAME
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_DATABASE
        - name: DATABASE_USER
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: MYSQL_USER
        - name: DATABASE_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_PASSWORD
        ports:
        - containerPort: 80
```
### ধাপ ৬: ওয়েব অ্যাপ্লিকেশনের সার্ভিস তৈরি করা
#### Web Application Service YAML ফাইল (`webapp-service.yaml`)

```
nano webapp-service.yaml
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: webapp
spec:
  selector:
    app: webapp
  ports:
  - protocol: TCP
    port: 8085
    targetPort: 80
  type: LoadBalancer
```
### ধাপ ৭: phpMyAdmin ডিপ্লয় করা
#### phpMyAdmin Deployment YAML ফাইল (`phpmyadmin-deployment.yaml`)

```
nano phpmyadmin-deployment.yaml
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: phpmyadmin
spec:
  replicas: 1
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
        ports:
        - containerPort: 80
        env:
        - name: PMA_HOST
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: PMA_HOST
        - name: PMA_PORT
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: PMA_PORT
        - name: MYSQL_DATABASE
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: app-configmap
              key: MYSQL_PASSWORD
```
### ধাপ ৮: phpMyAdmin এর জন্য সার্ভিস তৈরি করা
#### phpMyAdmin Service YAML ফাইল (`phpmyadmin-service.yaml`)

```
nano phpmyadmin-service.yaml
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: phpmyadmin-service
  labels:
    app: phpmyadmin
spec:
  selector:
    app: phpmyadmin
  ports:
    - protocol: TCP
      port: 8086
      targetPort: 80
  type: LoadBalancer
```

এই ফাইলগুলি তৈরি করার পরে, নিম্নলিখিত কমান্ডগুলি চালান:

```sh
kubectl apply -f mysql-pv-pvc.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
kubectl apply -f app-configmap.yaml
kubectl apply -f webapp-deployment.yaml
kubectl apply -f webapp-service.yaml
kubectl apply -f phpmyadmin-deployment.yaml
kubectl apply -f phpmyadmin-service.yaml
```

```
kubectl get deploy
```
```
kubectl get pod
```
```
kubectl get pv,pvc
```
```
kubectl get configmap
```
```
kubectl get svc
```

### Delete all 
```
kubectl delete deploy webapp phpmyadmin mysql
kubectl delete svc webapp phpmyadmin-service mysql
kubectl delete configmap app-configmap
```
### Delete PV,PVC
```
kubectl delete pvc configmap-pvc-claim
kubectl delete pv configmap-nfs-pv
```

### উপসংহার

এই ধাপগুলি অনুসরণ করে, আপনি ConfigMap ব্যবহার করে একটি সম্পূর্ণ অ্যাপ্লিকেশন Kubernetes এ ডিপ্লয় করতে পারবেন। এই প্রক্রিয়াটি আপনাকে কনফিগারেশন ডেটা অ্যাপ্লিকেশন কোড থেকে আলাদা রাখতে এবং বিভিন্ন পরিবেশে সহজে পরিচালনা করতে সাহায্য করবে।

---

### Secret ব্যবহার করে

#### Secret YAML ফাইল (`mysql-secret.yaml`)

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secrets
type: Opaque
data:
  root-password: c3VwZXItc2VjcmV0LXBhc3N3b3Jk  # "super-secret-password" এর base64 এনকোডেড মান
```

#### MySQL Deployment YAML ফাইল (`mysql-deployment.yaml`)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: mysql:5.7
        name: mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secrets
              key: root-password
        ports:
        - containerPort: 3306
          name: mysql
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: mysql-pv-claim
```

#### MySQL Service YAML ফাইল (`mysql-service.yaml`)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  ports:
  - port: 3306
  selector:
    app: mysql
```

#### phpMyAdmin Deployment YAML ফাইল (`phpmyadmin-deployment.yaml`)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: phpmyadmin
spec:
  replicas: 1
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
        ports:
        - containerPort: 80
        env:
        - name: PMA_HOST
          value: mysql
        - name: PMA_PORT
          value: "3306"
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secrets
              key: root-password
```

#### phpMyAdmin Service YAML ফাইল (`phpmyadmin-service.yaml`)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: phpmyadmin
spec:
  selector:
    app: phpmyadmin
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
```

এই ফাইলগুলি তৈরি করার পরে, নিম্নলিখিত কমান্ডগুলি চালান:

```sh
kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
kubectl apply -f phpmyadmin-deployment.yaml
kubectl apply -f phpmyadmin-service.yaml
```

এই ধাপগুলি অনুসরণ করে আপনি MySQL ডাটাবেস এবং phpMyAdmin ডিপ্লয় করতে পারবেন, এবং Secret ব্যবহার করে ডাটাবেস পাসওয়ার্ড সুরক্ষিত রাখতে পারবেন। যদি আপনার আরও প্রশ্ন থাকে বা সাহায্য প্রয়োজন হয়, নির্দ্বিধায় জিজ্ঞাসা করুন!
