# How to Setup Dynamic NFS Provisioning in a Kubernetes Cluster

#### Show NFS Server Share:
showmount -e [NFS Server IP/FQDN]

```
showmount -e 192.168.0.96
```
Way-01
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/nfs-share/kubernetes
```
Way-02
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/nfs-share/kubernetes \
    --set storageClass.onDelete=retain \
    --set storageClass.pathPattern='/${.PVC.namespace}-${.PVC.name}' 
```
Way-03
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
  --create-namespace \
  --namespace nfs-provisioner \
  --set nfs.server=nfs.paulco.xyz \
  --set nfs.path=/nfs-share/kubernetes
```

#### Reference:
- [NFS Provisioner Plugins for Kubernetes](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git)
- [Dynamic-NFS-Provisioning](https://hbayraktar.medium.com/how-to-setup-dynamic-nfs-provisioning-in-a-kubernetes-cluster-cbf433b7de29)
