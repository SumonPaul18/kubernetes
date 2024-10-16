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
#
### Way-2
#### Create PV-PVC-POD with NFS Server
    nano nfs-pv-pvc-pod.yaml
####
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: nfs-pv
    spec:
      capacity:
        storage: 10Gi
      volumeMode: Filesystem
      accessModes:
        - ReadWriteMany
      persistentVolumeReclaimPolicy: Recycle
      storageClassName: nfs
      mountOptions:
        - hard
        - nfsvers=4.1
      nfs:
        path: /nfs-share/kubernetes/html
        server: 192.168.0.96
    ---
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: nfs-pvc
    spec:
      storageClassName: nfs
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 10Gi
    ---
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx-pv-pod
    spec:
      volumes:
        - name: nginx-pv-storage
          persistentVolumeClaim:
            claimName: nfs-pvc
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
              name: "nginx-server"
          volumeMounts:
            - mountPath: "/usr/share/nginx/html"
              name: nginx-pv-storage
####
    kubectl create -f nfs-pv-pvc-pod.yaml
####
    kubectl get pv,pvc,pod
####
    kubectl port-forward nginx-pv-pod 8025:80 --address 0.0.0.0
#
