# How to Setup Dynamic NFS Provisioning in a Kubernetes Cluster

Table of Contents
Steps 1: Prepare the NFS Server
Steps 2: Install and Configure NFS Client Provisioner
Steps 3: Master & Worker Nodes Install nfs-common
Steps 3: Create Persistent Volume Claims (PVCs)

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
