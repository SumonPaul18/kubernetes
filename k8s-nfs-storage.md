## How to Use NFS Stoarge with Kubernetes

### Requirements
- Ready NFS Server
- Ready Share Direcotry
- Allow From All Network

### From K8s Master Node
- Ready NFS Client
- Verify to access NFS Server from K8s all Node

#### Verifying to PV in K8s Master Node
    kbectl get pv
#### Verifying to PVC in K8s Master Node
    kbectl get pvc
#### Verifying to PODS in K8s Master Node
    kbectl get pods



