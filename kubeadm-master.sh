#!/bin/bash
# Assign IP Addresses ASK using Shell Script
bgreen='\033[1;32m'
red='\033[0;31m'
nc='\033[0m'
bold="\033[1m"
blink="\033[5m"
echo
echo -e "${bgreen} Configure as Kubeadm Master Node ${nc} "
echo
systemctl is-active --quiet kubelet && echo Kubelet is Running
echo
kubeadm version

#kubeadm init
echo
read -p "$(echo -e "${bgreen}${bold}${blink}TYPE MASTER NODE IP: ${nc}")" MASTERIP
echo
read -p "$(echo -e "${bgreen}${bold}${blink}TYPE POD-NETWORK-CIDR Ex-(10.10.0.0/16): ${nc}")" PODCIDR
sudo kubeadm init --apiserver-advertise-address=$MASTERIP --pod-network-cidr=$PODCIDR | tee kubeadm-init-log.txt

#To start using your cluster, you need to run the following as a regular user:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Alternatively, if you are the root user, you can run:
export KUBECONFIG=/etc/kubernetes/admin.conf
echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> .bashrc

#Verify Cluster, Nodes and Pods status using kubectl commands
kubectl cluster-info
kubectl get nodes
kubectl get pod

#Configuring Network Plugins
sudo kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

#Verify To display the network status
kubectl get pods --all-namespaces

echo -e "${bgreen} Joining worker node to a Kubernetes Cluster ${nc} "
#Joining worker node to a Kubernetes Cluster
kubeadm token create — print-join-command

