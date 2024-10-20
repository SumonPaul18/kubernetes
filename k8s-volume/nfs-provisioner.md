# How to Setup Dynamic NFS Provisioning in a Kubernetes Cluster

#### Show NFS Server Share:
showmount -e [NFS Server IP/FQDN]

```
showmount -e 192.168.0.96
```
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/nfs-share/kubernetes
```

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/nfs-share/kubernetes \
    --set storageClass.onDelete=retain \
    --set storageClass.pathPattern='/${.PVC.namespace}-${.PVC.name}' 
```


#### Reference:
- [NFS Provisioner Plugins for Kubernetes](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git)
