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

#
## Bellow Step perform Only on Master Node    
### Step 8 - Configuring as a Master Node
Switch to the master server node, and enter the following:<br>
<b><i>Note:</b></i> Replace your Endpoint Address as Master Node FQDN (master.paulco.xyz)
####
    sudo kubeadm init --apiserver-advertise-address=<MasterNode-PrivateIP> --pod-network-cidr=10.244.0.0/16 
####    
    sudo kubeadm init --control-plane-endpoint=master.paulco.xyz
####
    sudo kubeadm init --pod-network-cidr=10.10.0.0/16

Once this command finishes, it will display a kubeadm join message at the end. Make a note of the whole entry. This will be used to join the worker nodes to the cluster.

#
<details>
 <summary> <b> If You Get Error: When we run "kubeadm init" </summary> </b>

<b> This Error Like This: </b>
> [init] Using Kubernetes version: v1.29.3 <br>
> [preflight] Running pre-flight checks <br>
>	[WARNING Swap]: swap is supported for cgroup v2 only; the NodeSwap feature gate of the kubelet is beta but disabled by default <br>
>	[WARNING FileExisting-tc]: tc not found in system path <br>
> error execution phase preflight: [preflight] Some fatal errors occurred: <br>
>	[ERROR CRI]: container runtime is not running: output: time="2024-03-19T04:51:36-04:00" level=fatal msg="validate service connection: validate CRI v1 runtime API for endpoint \"unix:///var/run/containerd/containerd.sock\": rpc error: code = Unimplemented desc = unknown service runtime.v1.RuntimeService" <br>
> , error: exit status 1 <br>
> [preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...` <br>
> To see the stack trace of this error execute with --v=5 or higher <br>

<b> Solution: </b>
####
    rm -f /etc/containerd/config.toml
    systemctl restart containerd
####
Aging Run kubeadm init Command
</details>

#
<details>
 <summary> <b> If We Want to Reset Kubeadm init: When Get Error "kubeadm init" </summary> </b>

   ####
       kubeadm reset
</details>

#
<details>
 <summary> <b> If We Want to Uninstall Kubernetes on Ubuntu </summary> </b>

   ####
       
       # Kube Admin Reset
       kubeadm reset
       # Remove all packages related to Kubernetes
       apt remove -y kubeadm kubectl kubelet kubernetes-cni --allow-change-held-packages
       apt purge -y kube*
       # Remove docker containers/images
       docker image prune -a
       systemctl restart docker
       apt purge -y docker-engine docker docker.io docker-ce docker-ce-cli containerd containerd.io runc --allow-change-held-packages
       # Remove parts
       apt autoremove -y
       # Remove all folder associated to kubernetes, etcd, and docker
       rm -rf ~/.kube
       rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/lib/etcd2/ /var/run/kubernetes ~/.kube/* 
       rm -rf /var/lib/docker /etc/docker /var/run/docker.sock
       rm -f /etc/apparmor.d/docker /etc/systemd/system/etcd* 
       # Delete docker group (optional)
       groupdel docker
       # Clear the iptables
       iptables -F && iptables -X
       iptables -t nat -F && iptables -t nat -X
       iptables -t raw -F && iptables -t raw -X
       iptables -t mangle -F && iptables -t mangle -X
</details>

#

To start using your cluster, you need to run the following as a regular user:
####
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:
####
    export KUBECONFIG=/etc/kubernetes/admin.conf
####
Setup export KUBECONFIG in .bashrc file
####
    echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> .bashrc
    
Verify Cluster, Nodes and Pods status using kubectl commands
####
    kubectl cluster-info
####
    kubectl get nodes
####
    kubectl get pods -A

### Step 9 - Configuring Network Plugins
A Pod Network is a way to allow communication between different nodes in the cluster. 

We have Differents Types Network Plugins:

If we use the Calico virtual network:
####
    sudo kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/tigera-operator.yaml
If we use the flannel virtual network:
####
    sudo kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

Allow the process to complete.

Verify To display the network status, use the following command:
####
    kubectl get pods --all-namespaces
Check cluster status:
####
    kubectl cluster-info

### Step 10 - Joining worker node to a Kubernetes Cluster
On each worker node, use the <b>kubeadm join</b> command on each worker node to connect it to the cluster.
View the master join token:
####
    kubeadm token create --print-join-command
<b>Output Like:</b>
> kubeadm join 172.30.20.20:6443 — token cdm6fo.dhbrxyleqe5suy6e \
— discovery-token-ca-cert-hash sha256:1fc51686afd16c46102c018acb71ef9537c1226e331840e7d401630b96298e7d
    
Verify all tokens:

    kubeadm token list
#
## This Step perform on Worker Node for Joining with k8s Cluster
####
Copy the kubeadm join token & Paste on <b>Worker Node</b>
####
    kubeadm join 172.30.20.20:6443 — token cdm6fo.dhbrxyleqe5suy6e \
    — discovery-token-ca-cert-hash sha256:1fc51686afd16c46102c018acb71ef9537c1226e331840e7d401630b96298e7d
####
#
## Verify from Master Node
####
    kubectl get nodes
####
    kubectl get nodes -o wide
The system should display the worker nodes that you joined to the cluster.

Check cluster status:
####
    kubectl cluster-info
####

