## How to Connect NFS Server with Kubernetes

### Requirements
- Ready NFS Server
- Ready Share Direcotry
- Allow From All Network

### From K8s Master Node
- Ready NFS Client
- Verify to access NFS Server from K8s all Node
#### In My Case:
- <b>My NFS Server IP: </b> 192.168.0.96
- <b>NFS Share Path:</b> /nfs-share/kubernetes

#### Verifying to PV in K8s Master Node
    kbectl get pv
#### Verifying to PVC in K8s Master Node
    kbectl get pvc
#### Verifying to PODS in K8s Master Node
    kbectl get pods
#### Create PV-PVC-POD with NFS Server
    nano nfs-pv-pvc-pod.yaml
####
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: nfspv
    spec:
      capacity:
        storage: 2Gi
      accessModes:
        - ReadWriteOnce
      nfs:
        server: 192.168.0.96
        path: /nfs-share/kubernetes
      persistentVolumeReclaimPolicy: Retain
    
    ---
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: nfspvc
    spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 2Gi
    ---
    #Attach PVCs to Pods
    apiVersion: v1
    kind: Pod
    metadata:
      name: k8snginx
    spec:
      containers:
      - name: k8snginx
        image: nginx
        volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: nfs-volume
      volumes:
      - name: nfs-volume
        nfs:
          server: 192.168.0.96
          path: /nfs-share/kubernetes/html

####
    kubectl create -f nfs-pv-pvc-pod.yaml
####
    kubectl get pv,pvc,pod


