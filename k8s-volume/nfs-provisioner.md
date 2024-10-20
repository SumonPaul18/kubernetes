

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.96 \
    --set nfs.path=/exported/path
```


#### Reference:
- [NFS Provisioner Plugins for Kubernetes](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git)
