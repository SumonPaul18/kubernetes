# Kubernetes Volumes

## পরিচিতি
Kubernetes এ Volume হলো একটি ডিরেক্টরি যা পডের কন্টেইনারগুলির জন্য অ্যাক্সেসযোগ্য। এটি কন্টেইনারের লাইফটাইমের বাইরেও ডেটা সংরক্ষণ করতে পারে। Kubernetes বিভিন্ন ধরনের Volume সমর্থন করে যা বিভিন্ন পরিস্থিতিতে ব্যবহার করা যেতে পারে।

## Volume এর ধরন
Kubernetes এ বিভিন্ন ধরনের Volume রয়েছে, যেমন:

1. **emptyDir**: পড তৈরি হওয়ার সময় একটি খালি ডিরেক্টরি তৈরি হয়।
2. **hostPath**: হোস্ট মেশিনের একটি নির্দিষ্ট ফাইল বা ডিরেক্টরি মাউন্ট করে।
3. **nfs**: একটি NFS (Network File System) শেয়ার মাউন্ট করে।
4. **persistentVolumeClaim**: একটি Persistent Volume Claim (PVC) ব্যবহার করে।
5. **configMap**: একটি ConfigMap এর ডেটা মাউন্ট করে।
6. **secret**: একটি Secret এর ডেটা মাউন্ট করে।

## Volume ব্যবহার করার ধাপ

### 1. emptyDir উদাহরণ
```
nano emptydir.yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: emptydir-example
spec:
  containers:
  - name: test-container
    image: busybox
    command: [ "sh", "-c", "sleep 3600" ]
    volumeMounts:
    - mountPath: /test-emptydir
      name: test-volume
  volumes:
  - name: test-volume
    emptyDir: {}
```
```
kubectl apply -f secret.yaml
```

### 2. hostPath উদাহরণ
```
nano hostpath.yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-example
spec:
  containers:
  - name: test-container
    image: busybox
    command: [ "sh", "-c", "sleep 3600" ]
    volumeMounts:
    - mountPath: /test-hostpath
      name: test-volume
  volumes:
  - name: test-volume
    hostPath:
      path: /data
      type: Directory
```
```
kubectl apply -f hostpath.yaml
```

### 3. nfs উদাহরণ
```
nano nfs-vol.yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nfs-example
spec:
  containers:
  - name: test-container
    image: busybox
    command: [ "sh", "-c", "sleep 3600" ]
    volumeMounts:
    - mountPath: /test-nfs
      name: test-volume
  volumes:
  - name: test-volume
    nfs:
      server: nfs-server.example.com
      path: /path/to/share
```

### 4. persistentVolumeClaim উদাহরণ
```
nano pvc.yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pvc-example
spec:
  containers:
  - name: test-container
    image: busybox
    command: [ "sh", "-c", "sleep 3600" ]
    volumeMounts:
    - mountPath: /test-pvc
      name: test-volume
  volumes:
  - name: test-volume
    persistentVolumeClaim:
      claimName: my-pvc
```

### 5. configMap উদাহরণ
```
nano configmap.yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-example
spec:
  containers:
  - name: test-container
    image: busybox
    command: [ "sh", "-c", "sleep 3600" ]
    volumeMounts:
    - mountPath: /test-configmap
      name: test-volume
  volumes:
  - name: test-volume
    configMap:
      name: my-config
```

### 6. secret উদাহরণ
```
nano secret.yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-example
spec:
  containers:
  - name: test-container
    image: busybox
    command: [ "sh", "-c", "sleep 3600" ]
    volumeMounts:
    - mountPath: /test-secret
      name: test-volume
  volumes:
  - name: test-volume
    secret:
      secretName: my-secret
```

### ফাইলের নাম
প্রতিটি উদাহরণের জন্য YAML ফাইল তৈরি করুন, যেমন `emptydir-example.yaml`, `hostpath-example.yaml`, ইত্যাদি।

### রান করা
```sh
kubectl apply -f <filename>.yaml
```

### টেস্ট করা
```sh
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### ডিলেট করা
```sh
kubectl delete -f <filename>.yaml
```

---

এই ডকুমেন্টটি গিটহাবে রাখতে পারেন এবং প্রয়োজনে পরিবর্তন করতে পারেন। কোনো প্রশ্ন থাকলে জানাবেন! 😊

[1](https://kubernetes.io/docs/concepts/storage/volumes/): [Volumes - Kubernetes](https://kubernetes.io/docs/concepts/storage/volumes/)
[2](https://kubernetes.io/docs/concepts/storage/persistent-volumes/): [Persistent Volumes - Kubernetes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
