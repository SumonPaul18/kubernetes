## Secrets ব্যবহার করে একটি সাধারণ ওয়েব অ্যাপ্লিকেশন এবং একটি ডাটাবেস (MySQL) Kubernetes এ ডিপ্লয় করার প্রক্রিয়া ধাপে ধাপে  নিচে দেওয়া হল।

Kubernetes Secrets হলো একটি API অবজেক্ট যা সংবেদনশীল ডেটা যেমন পাসওয়ার্ড, টোকেন, বা কী সংরক্ষণ করতে ব্যবহৃত হয়। Secrets তৈরি করার জন্য আপনাকে প্রথমে আপনার ডেটা base64 এনকোড করতে হবে।

### ধাপ ১: Base64 এনকোডিং করা।

#### **Base64 এনকোডিং কিভাবে করবেন**

আপনার ডেটা base64 এনকোড করতে, আপনি `echo` এবং `base64` কমান্ড ব্যবহার করতে পারেন। 

উদাহরণস্বরূপঃ আমরা একটি mysql database এর configuration data যেমন,"root password","database name","user","user password","database host","database port" এর গুলোর Value base64 এ encode করতে চাই। তাহলে আপনি নিম্নলিখিত কমান্ডগুলো ব্যবহার করতে পারেন:

**Base64 encoding for "root password"**
```sh
echo -n 'secrets123' | base64
```

এর আউটপুট হবে: `c2VjcmV0czEyMw==`

**Base64 encoding for "database name"**
```sh
echo -n 'k8s-secret' | base64
```

এর আউটপুট হবে: `azhzLXNlY3JldA==`

**Base64 encoding for "user"**
```sh
echo -n 'sumon' | base64
```

এর আউটপুট হবে: `c3Vtb24=`

**Base64 encoding for "user password"**
```sh
echo -n 'secrets' | base64
```

এর আউটপুট হবে: `c2VjcmV0cw==`

**Base64 encoding for "database host"**
```sh
echo -n 'mysql' | base64
```

এর আউটপুট হবে: `bXlzcWw=`

**Base64 encoding for "database port"**
```sh
echo -n '3306' | base64
```

এর আউটপুট হবে: `MzMwNg==`


### Base64 ডিকোডিং

যদি কখনও base64 এনকোড করা ডেটা ডিকোড করতে হয়, তাহলে আপনি নিম্নলিখিত কমান্ডটি ব্যবহার করতে পারেন:

```sh
echo 'YWRtaW4=' | base64 --decode
```

এর আউটপুট হবে: `admin`

```sh
echo 'cGFzc3dvcmQ=' | base64 --decode
```

এর আউটপুট হবে: `password`

এইভাবে, আপনি Kubernetes Secrets তৈরি এবং base64 এনকোডিং ও ডিকোডিং করতে পারেন।


### ধাপ ২: Secrets YAML ফাইল (`secrets.yaml`)
এখন, এনকোড করা ভ্যালু ব্যবহার করে একটি Secrets YAML ফাইল তৈরি করুন:
```
nano secrets.yaml
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  MYSQL_ROOT_PASSWORD: Y29uZmlnbWFw
  MYSQL_DATABASE: Y29uZmlnbWFwLWRi
  MYSQL_USER: YWRtaW4=
  MYSQL_PASSWORD: Y29uZmlnbWFw
  PMA_HOST: bXlzcWw=
  PMA_PORT: MzMwNg==
```
**নোট:** এখানে data ফিল্ডে base64 এনকোডেড ভ্যালু ব্যবহার করা হয়েছে। আপনি echo -n 'value' | base64 কমান্ড ব্যবহার করে এনকোড করতে পারেন।

### ধাপ ৩: MySQL এর জন্য Persistent Volume তৈরি করা
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

### ধাপ ৪: MySQL Deployment YAML ফাইল (`mysql-deployment.yaml`)
Secrets ব্যবহার করে `mysql-deployment.yaml` ফাইল তৈরি করা। 

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
            secretKeyRef:
              name: app-secrets
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: app-secrets
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

### ধাপ ৫: MySQL Service YAML ফাইল (`mysql-service.yaml`)

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

### ধাপ ৬: Web Application Deployment YAML ফাইল (`webapp-deployment.yaml`)
Secrets ব্যবহার করে `webapp-deployment.yaml` ফাইল তৈরি করা। 
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
            secretKeyRef:
              name: app-secrets
              key: PMA_HOST
        - name: DATABASE_NAME
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_DATABASE
        - name: DATABASE_USER
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_USER
        - name: DATABASE_PASSWORD
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_PASSWORD
        ports:
        - containerPort: 80
```

### ধাপ ৭: Web Application Service YAML ফাইল (`webapp-service.yaml`)

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

### ধাপ ৮: phpMyAdmin Deployment YAML ফাইল (`phpmyadmin-deployment.yaml`)

Secrets ব্যবহার করে `phpmyadmin-deployment.yaml` ফাইল তৈরি করা। 
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
            secretKeyRef:
              name: app-secrets
              key: PMA_HOST
        - name: PMA_PORT
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: PMA_PORT
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: MYSQL_PASSWORD
```

### ধাপ ৯: phpMyAdmin Service YAML ফাইল (`phpmyadmin-service.yaml`)

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

### ধাপ ১০: এই ফাইলগুলি রান করা: 

```sh
kubectl apply -f secrets.yaml
kubectl apply -f mysql-pv-pvc.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
kubectl apply -f webapp-deployment.yaml
kubectl apply -f webapp-service.yaml
kubectl apply -f phpmyadmin-deployment.yaml
kubectl apply -f phpmyadmin-service.yaml
```
### অথবা
```
kubectl apply -f .
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
kubectl get secret
```
```
kubectl get svc
```

### Delete all 
```
kubectl delete deploy webapp phpmyadmin mysql
kubectl delete svc webapp phpmyadmin-service mysql
kubectl delete secret app-secrets
```
### Delete PV,PVC
```
kubectl delete pvc configmap-pvc-claim
kubectl delete pv configmap-nfs-pv
```

এই ধাপগুলি অনুসরণ করে আপনি MySQL ডাটাবেস এবং phpMyAdmin ডিপ্লয় করতে পারবেন, এবং Secrets ব্যবহার করে ডাটাবেস পাসওয়ার্ড সুরক্ষিত রাখতে পারবেন। যদি আপনার আরও প্রশ্ন থাকে বা সাহায্য প্রয়োজন হয়, নির্দ্বিধায় জিজ্ঞাসা করুন!
