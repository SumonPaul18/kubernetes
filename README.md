## Install-Kubernetes-Kubeadm-on-Ubuntu
![kube](https://github.com/SumonPaul18/Install-Kubernetes-Kubeadm-on-Ubuntu/blob/main/InstallKubeAdm.png)

Kubernetes is an open-source container orchestration tool that helps deploy, scale, and manage containerized applications. Google initially designed Kubernetes and is now maintained by the Cloud Native Computing Foundation. With Kubernetes, you can freely make use of the hybrid, on-premise, and public cloud infrastructure to run deployment tasks of your project.<br>

Kubernetes works with Docker, Containerd, and CRI-O currently.<br>
####
We can run Kubernetes locally using the below methods:<br>
  - <b>Minikube:</b> A single-node Kubernetes cluster for development and testing
  - <b>Kubeadm:</b>  A multi-node Kubernetes cluster

####
Here, we will see how to deploy a multi-node Kubernetes cluster using the 
### This Guidebook Provides Step-by-Step Instructions for Installing Kubernetes on Ubuntu 22.04.xx

### Before you begin
  - 2 or more Linux servers running Ubuntu 22.04
  - root privileges
  - 3.75 GB or more of Ram - for better performance, use 6 GB
  - 2 CPUs or more
  - Full network connectivity between all machines in the cluster (public or private network is fine)
  - Unique hostname, MAC address, and product_uuid for every node.
  - Certain ports are open on your machines.
  - Swap disabled. You MUST disable swap for the kubelet to work properly.

### Step 1:
#### Settings up Static IP and Hostname and FQDN for (Master-Worker) Node
    git clone https://github.com/SumonPaul18/Install-Kubernetes-Kubeadm-on-Ubuntu.git
    chmod -R +x Install-Kubernetes-Kubeadm-on-Ubuntu
    . Install-Kubernetes-Kubeadm-on-Ubuntu/iphostname.sh
    
### Step 2:
#### Install-Kubernetes-Kubeadm-on-Ubuntu for (Master-Worker) Node
    git clone https://github.com/SumonPaul18/Install-Kubernetes-Kubeadm-on-Ubuntu.git
    chmod -R +x Install-Kubernetes-Kubeadm-on-Ubuntu
    . Install-Kubernetes-Kubeadm-on-Ubuntu/install-kubeadm-ubuntu.sh
