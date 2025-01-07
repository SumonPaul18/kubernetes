## ConfigMap ব্যবহার করে একটি সাধারণ ওয়েব অ্যাপ্লিকেশন এবং একটি ডাটাবেস (MySQL) Kubernetes এ ডিপ্লয় করার প্রক্রিয়া ধাপে ধাপে  নিচে দেওয়া হল।

### ধাপ ১: MySQL ডাটাবেস ডিপ্লয় করা

প্রথমে, MySQL ডাটাবেসের জন্য একটি ডিপ্লয়মেন্ট এবং সার্ভিস তৈরি করুন।

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
          value: "rootpassword"
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

#### Persistent Volume এবং Persistent Volume Claim YAML ফাইল (`mysql-pv.yaml`)

```
nano mysql-pv.yaml
```

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
spec:
  resources:
    requests:
      storage: 1Gi
  accessModes:
    - ReadWriteOnce
```

এই ফাইলগুলি তৈরি করার পরে, নিম্নলিখিত কমান্ডগুলি চালান:

```sh
kubectl apply -f mysql-pv.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
```

### ধাপ ২: ConfigMap তৈরি করা

এখন, অ্যাপ্লিকেশনের জন্য প্রয়োজনীয় কনফিগারেশন ডেটা সংরক্ষণ করতে একটি ConfigMap তৈরি করুন।

#### ConfigMap YAML ফাইল (`app-configmap.yaml`)

```
nano app-configmap.yaml
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database_url: "mysql"
  database_name: "mydatabase"
  database_user: "root"
  database_password: "rootpassword"
```

এই ConfigMap তৈরি করতে, নিম্নলিখিত কমান্ডটি চালান:

```sh
kubectl apply -f app-configmap.yaml
```

### ধাপ ৩: ওয়েব অ্যাপ্লিকেশন ডিপ্লয় করা

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
        image: your-webapp-image
        env:
        - name: DATABASE_URL
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: database_url
        - name: DATABASE_NAME
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: database_name
        - name: DATABASE_USER
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: database_user
        - name: DATABASE_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: database_password
        ports:
        - containerPort: 80
```

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
    port: 80
    targetPort: 80
  type: LoadBalancer
```

এই ফাইলগুলি তৈরি করার পরে, নিম্নলিখিত কমান্ডগুলি চালান:

```sh
kubectl apply -f webapp-deployment.yaml
kubectl apply -f webapp-service.yaml
```

### উপসংহার

এই ধাপগুলি অনুসরণ করে, আপনি ConfigMap ব্যবহার করে একটি সম্পূর্ণ অ্যাপ্লিকেশন Kubernetes এ ডিপ্লয় করতে পারবেন। এই প্রক্রিয়াটি আপনাকে কনফিগারেশন ডেটা অ্যাপ্লিকেশন কোড থেকে আলাদা রাখতে এবং বিভিন্ন পরিবেশে সহজে পরিচালনা করতে সাহায্য করবে।
