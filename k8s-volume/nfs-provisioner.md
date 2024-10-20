

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/exported/path
```

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.100.105 \
    --set nfs.path=/mnt/kubernetes-volumes \
    --set storageClass.onDelete=retain \
    --set storageClass.pathPattern='/${.PVC.namespace}-${.PVC.name}' \
    --kubeconfig /etc/rancher/k3s/k3s.yaml 
```


#### Reference:
- [NFS Provisioner Plugins for Kubernetes](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git)
