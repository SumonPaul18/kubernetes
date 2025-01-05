# How to Setup Dynamic NFS Provisioning in a Kubernetes Cluster

**Table of Contents**

Steps 1: Prepare the NFS Server

Steps 2: Install and Configure NFS Client Provisioner

Steps 3: Master & Worker Nodes Install nfs-common

Steps 3: Create Persistent Volume Claims (PVCs)

#

**Kubernetes Cluster এ NFS Volume ব্যবহার: পদ্ধতি এবং বাস্তব অভিজ্ঞতা**

---

**Kubernetes Cluster এ ডেটা সংরক্ষনের জন্য কি ধরনের volume ব্যবহার করা হয়?**

**Pros:**
1. **NFS (Network File System):** সহজে কনফিগার করা যায় এবং বিভিন্ন নোড থেকে এক্সেস করা যায়.
2. **Ceph:** উচ্চ পারফরমেন্স এবং স্কেলেবিলিটি প্রদান করে.
3. **Local Persistent Volumes:** কম লেটেন্সি এবং উচ্চ পারফরমেন্স প্রদান করে.

**Cons:**
1. **NFS:** উচ্চ লোডে পারফরমেন্স কমে যেতে পারে.
2. **Ceph:** কনফিগারেশন এবং মেইনটেনেন্স জটিল হতে পারে.
3. **Local Persistent Volumes:** ডেটা রেপ্লিকেশন এবং ব্যাকআপ চ্যালেঞ্জিং হতে পারে.

**Real Life Production Environment এ ব্যবহৃত Volume:**
- **Ceph এবং NFS** সাধারণত ব্যবহৃত হয়, কারণ এগুলো স্কেলেবিলিটি এবং রিলায়েবিলিটি প্রদান করে.

**Kubernetes Cluster এ NFS Volume ব্যবহার করার পদ্ধতি:**

1. **NFS সার্ভার সেটআপ করুন (IP: 192.168.0.33):**
   - `sudo apt update`
   - `sudo apt install nfs-kernel-server -y`
   - ডিরেক্টরি তৈরি করুন এবং শেয়ার করুন:
     ```bash
     sudo mkdir /mnt/k8s-dynamic-store
     sudo chown -R nobody:nogroup /mnt/k8s-dynamic-store
     sudo chmod 2770 /mnt/k8s-dynamic-store
     ```
   - `/etc/exports` ফাইলে এন্ট্রি যোগ করুন:
     ```bash
     /mnt/k8s-dynamic-store 192.168.0.0/24(rw,sync,no_subtree_check)
     ```
   - সার্ভার রিস্টার্ট করুন:
     ```bash
     sudo exportfs -a
     sudo systemctl restart nfs-kernel-server
     ```

2. **Kubernetes Cluster এ NFS প্রভিশনার সেটআপ করুন:**
   - Helm ইনস্টল করুন:
     ```bash
     curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
     chmod 700 get_helm.sh
     ./get_helm.sh
     ```
   - NFS প্রভিশনার ডিপ্লয় করুন:
     ```bash
     helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
     helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --create-namespace -n nfs-provisioning --set nfs.server=192.168.0.33 --set nfs.path=/mnt/k8s-dynamic-store
     ```

#

#### Show NFS Server Share:
showmount -e [NFS Server IP/FQDN]

```
showmount -e 192.168.0.96
```
#### Verify Helm Installation and Others
```
helm version
```
```
helm repo list
```
```
helm list
```
#### Way-01
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/nfs-share/kubernetes
```
#### Way-02
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/nfs-share/kubernetes \
    --set storageClass.onDelete=retain \
    --set storageClass.pathPattern='/${.PVC.namespace}-${.PVC.name}' 
```
#### Way-03
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
  --create-namespace \
  --namespace nfs-provisioner \
  --set nfs.server=nfs.paulco.xyz \
  --set nfs.path=/nfs-share/kubernetes
```
#### Verify NFS Provisioner
```
kubectl get sc
```
```
kubectl get pv,pvc
```
#### Dynamic PVC Volume Create Testing:
```
nano dyna-nfsvol-nginx.yaml
```
```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nfs-nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      volumes:
        - name: nfs-nginx
          persistentVolumeClaim:
            claimName: nfs-pvc
      containers:
        - image: nginx
          name: nginx
          volumeMounts:
            - name: nfs-nginx
              mountPath: /usr/share/nginx/html
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: nfs-client
  resources:
    requests:
      storage: 1Gi
```
#### Apply the Deployment:
```
kubectl apply -f dyna-nfsvol-nginx.yaml
```
#### Uninstallation NFS Provisioner
```
helm uninstall nfs-subdir-external-provisioner
```


#### Reference:
- [NFS Provisioner Plugins for Kubernetes](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git)
- [Dynamic-NFS-Provisioning](https://hbayraktar.medium.com/how-to-setup-dynamic-nfs-provisioning-in-a-kubernetes-cluster-cbf433b7de29)
