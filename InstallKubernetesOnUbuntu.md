## How to Install Kubernetes Using Kubeadm on Ubuntu 22.04.xx

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
### Goals
Install a Docker container and then install Kubernetes with two nodes on Ubuntu 20.04
  
  - 1. OS Update & Upgrade
  - Setting up hostnames
  - Disabling swap
  - Setting up the IPV4 bridge on all nodes
  - Installing Docker or a suitable containerization tool
  - Installing Kubernetes components on all nodes
  - Configuring master and worker nodes
  - Configuring Kubectl and Calico
  - Joining worker node to a Kubernetes Cluster

#### So, let's start the installation

### Step 1 - Update Ubuntu
Always recommended updating the system packages.

So let's go to the command:
####
    sudo apt update -y && sudo apt upgrade -y
### Step 2 - Assign Unique Hostname for Each Server Node
Decide which server to set as the master node. Then enter the command:
####
    sudo hostnamectl set-hostname master-node
####
If you have additional worker nodes, use this process to set a unique hostname on each.

### Step 2 - Disable Swap
Disable the swap memory on each Server:
####
    sudo swapoff –a
    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
### Step 2 - 


### Step 2 - Install Docker
Kubernetes requires an existing Docker installation.

Install Docker with the command:
####
    sudo apt install docker.io

#### Repeat the process on each server that will act as a node.

Check the installation (and version) by entering the following:
####
    docker ––version

### Step 3 - Start and Enable Docker
Set Docker to launch at boot by entering the following:
####
    sudo systemctl enable docker
####
    sudo systemctl start docker

Verify Docker is running:
####
    sudo systemctl status docker
####
    sudo systemctl start docker

Repeat on all the other nodes.

### Step 4 - Install Kubernetes
As we are downloading Kubernetes from a non-standard repository, it is essential to ensure that the software is authentic. This is done by adding a subscription key.

Enter the following to add a signing key in you on Ubuntu:
####
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

Then repeat the previous command to install the signing keys.

Repeat for each server node.

### Step 5 - Add Software Repositories
Kubernetes is not included in the default repositories. To add them, enter the following:
####
    sudo apt-add-repository "deb http://apt.kubernetes.io/kubernetes-xenial main"

Repeat for each server node.

### Step 6 - Kubernetes Installation Tools
Kubernetes Admin or Kubeadm is a tool that helps initialize a cluster. Its fast-track setup by using community-sourced best practices. Kubelet is the work package, which runs on every node and starts containers. The tool gives you command-line access to clusters.

Install Kubernetes tools with the command:
####
    sudo apt-get install kubeadm kubelet kubectl
####
    sudo apt-mark hold kubeadm kubelet kubectl

Allow the process to complete.

Verify the installation with:
####
    kubeadm version

Repeat for each server node.

#### Step 7 - Kubernetes Deployment
Begin Kubernetes Deployment



### Step 9 - Initialize Kubernetes on Master Node
Switch to the master server node, and enter the following:
####
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16

Once this command finishes, it will display a kubeadm join message at the end. Make a note of the whole entry. This will be used to join the worker nodes to the cluster.

Next, enter the following to create a directory for the cluster:
####
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

### Step 10 - Deploy Pod Network to Cluster
A Pod Network is a way to allow communication between different nodes in the cluster. This tutorial uses the flannel virtual network.

Enter the following:
####
    sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

Allow the process to complete.

Verify that everything is running and communicating:
####
    kubectl get pods --all-namespaces

### Step 11 - Join the Worker Node to Cluster
As indicated in Step 7, you can enter the kubeadm join command on each worker node to connect it to the cluster.

Switch to the w1 system and enter the command you noted from Step 8:
####
    kubeadm join --discovery-token abcdef.1234567890abcdef --discovery token-ca-cert-hash sha256:1234..cdef 1.2.3.4:6443

Replace the alphanumeric codes with those from your master server. Repeat for each worker node on the cluster. Wait a few minutes; then you can check the status of the nodes.

Switch to the master server, and enter:
####
    kubectl get nodes

The system should display the worker nodes that you joined to the cluster.

Node	Hostname	IP Address	vCPUs	RAM (GB)	OS
Master	master.letscloud.io	192.168.51.111	2	3.75	Ubuntu 20.04
W1	w1.letscloud.io	192.168.52.8	2	3.75	Ubuntu 20.04
W2	w2.letscloud.io	192.168.58.6	2	3.75	Ubuntu 20.04
Quick Tip
For beginners who still have no experience of deploying multiple containers, Minikube is a great way to start.

# Conclusion
After following the steps mentioned in this article carefully, you should now have Kubernetes installed on Ubuntu. Kubernetes allows you to launch and manage Docker containers across multiple servers in the pod.

#### In this article, we have explained the installation of the Kubernetes container management system on Ubuntu 20.04. Kubernetes has a lot of functionality and features to offer. The Kubernetes Official Documentation is the best place to learn.

If you have any questions about installing and configuring Kubernetes on Ubuntu, please contact us in the comments.
